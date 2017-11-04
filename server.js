'use strict';

const express = require('express');
const fs = require('fs');
const request = require('request');
const cheerio = require('cheerio');
const app = express();
const mysql = require('mysql');
const schedule = require('node-schedule');
const async = require('async');
const querystring = require('querystring');
const cookieParser = require('cookie-parser');

var client_id = '641daa3d66fd465caf3f1c8502d393aa'; // Your client id
var client_secret = '636653ffc01a4974a1a7dbdba6e73415'; // Your secret
var redirect_uri = 'http://localhost:8888/callback'; // Your redirect uri

let _refresh_token = false;
let _access_token = false;

let db = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'radio',
  password: 'playlist',
  database: 'radio_playlist_maker',
  multipleStatements: true
});


var theBuzz = schedule.scheduleJob('*/15 * * * * *', function() {
  parseWebsite("965 The Buzz", "http://krbz.tunegenie.com/");
});

var spotify = schedule.scheduleJob('*/5 * * * *', function() {
  refreshToken();
});

var spotifySong = schedule.scheduleJob('*/6 * * * * *', function() {
  let _song = "Say It Ain't So";
  let _artist = "Weezer";

  getSpotifySong(_song, _artist)
  .then(function(data) {
    return checkTrack(data.body, data.song, data.artist);
  })
  .then(function(data) {
    console.log("checkTrack done: ", data);
    return saveSpotifyData(data.song, data.artist, data.uri);
  })
  .then(function(data) {
    console.log("Saved data for song: ", data);
  })
  .catch(function(error) {
    console.log("Spotify Song Error: ", error);
  });
});

function getSpotifySong(song, artist) {
  return new Promise(function(fulfill,reject) {
    // requesting access token from refresh token
    let _url =
    "https://api.spotify.com/v1/search?q=track:" + song + "%20artist:" + artist + "&type=track";
    var authOptions = {
      url: _url,
      headers: {
        'Authorization': 'Bearer ' + _access_token
      }
    };

    request.get(authOptions, function(error, response, body) {
      if (!error && response.statusCode === 200) {
        fulfill({'body':JSON.parse(body).tracks, 'song':song, 'artist':artist});
      } else {
        console.log("body: ", body);
        reject("getSpotifySong requet error: " + response.statusCode);
      }
    });

  });
}




function checkTrack(tracks, song, artist) {
  return new Promise(function(fulfill,reject) {
    let _tracks = tracks;

    for (let i = 0; i < _tracks.items.length; i++) {
      console.log("Number ", i, ": ");
      console.log(_tracks.items[i].name);
      console.log(_tracks.items[i].artists[0].name);
      console.log(_tracks.items[i].uri);


      if (_tracks.items[i].name == song && _tracks.items[i].artists[0].name == artist) {
        console.log("This is the one!");
        fulfill({'song': song, 'artist': artist, 'uri':_tracks.items[i].uri});
        i = _tracks.items.length;
      }
      console.log(" ");
    }
    reject("No match found for song " + song);
  });
}

function saveSpotifyData(song, artist, uri) {
  return new Promise(function(fulfill,reject) {
    db.getConnection(function(err,spotifydb) {
      if(err) {
        return reject("saveTrack -conn|"+err);
      }
      let spotifyInsert = "INSERT INTO spotify (uri) SELECT * FROM (SELECT " + spotifydb.escape(uri) +
      ") AS tmp WHERE NOT EXISTS (SELECT uri FROM spotify WHERE uri = " +
      spotifydb.escape(uri) + ") LIMIT 1; ";

      spotifydb.query(spotifyInsert)
      .on('error',function(err) {
        return reject("saveSpotifyData query error: " + err);
      })
      .on('end', function () {
        let spotifySelect = "SELECT id FROM spotify WHERE uri = " + spotifydb.escape(uri) + " LIMIT 1; ";
        spotifydb.query(spotifySelect)
        .on('error',function(err) {
          return reject("saveSpotifyData query error: " + err);
        })
        .on('result', function (row) {
          console.log(row.id);
          let songlistUpdate = "UPDATE songlist SET spotify_id = " + row.id + " WHERE song = " + spotifydb.escape(song) +" AND artist = " + spotifydb.escape(artist) + "; ";
          console.log("songlistUpdate: ", songlistUpdate);
          spotifydb.query(songlistUpdate)
          .on('error',function(err) {
            return reject("saveSpotifyData query error: " + err);
          });
        });
      });
      spotifydb.release();
      return fulfill({'song':song, 'artist':artist, 'uri':uri});
    });
  });
}

function refreshToken() {
  // requesting access token from refresh token
  var authOptions = {
    url: 'https://accounts.spotify.com/api/token',
    headers: {
      'Authorization': 'Basic ' + (new Buffer(client_id + ':' +
      client_secret).toString('base64'))
    },
    form: {
      grant_type: 'refresh_token',
      refresh_token: _refresh_token
    },
    json: true
  };

  request.post(authOptions, function(error, response, body) {
    if (!error && response.statusCode === 200) {
      console.log("Token Refreshed: ", body.access_token);
      _access_token = body.access_token;
    }
  });
}
/**
* Generates a random string containing numbers and letters
* @param  {number} length The length of the string
* @return {string} The generated string
*/
var generateRandomString = function(length) {
  var text = '';
  var possible =
  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  for (var i = 0; i < length; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  return text;
};

var stateKey = 'spotify_auth_state';

function parseWebsite(name, url) {
  //let url = 'http://krbz.tunegenie.com/';
  let musicList = {};
  let songs = [];
  let _error = "";

  musicList.songs = songs;

  request(url, function(error, response, html) {
    if (!error) {
      let $ = cheerio.load(html);
      let title, artist, song;
      let count = 0;


      // The songs are located in 2 spots. Use hidden on open to only get 1 result per song
      $('.hidden-on-open .song').filter(function() {
        let data = $(this);

        // Get the title from the .song div
        title = data.text().trim();

        // artist is in the next div, which has no class
        artist = data.next().text().trim();

        // build the song
        song = {
          "title": title,
          "artist": artist
        };

        // add the song to the list of songs
        musicList.songs.push(song);

      });
    } else if (error) {
      _error += error + " || ";
    }

    let connection = mysql.createConnection({
      host: 'localhost',
      user: 'radio',
      password: 'playlist',
      database: 'radio_playlist_maker'
    });

    connection.connect();

    for (let i = 0; i < musicList.songs.length; i++) {


      let upsertQueries =
      "INSERT INTO songlist (song,artist,station) SELECT * FROM (SELECT " +
      connection.escape(musicList.songs[i].title) + "," +
      connection
      .escape(musicList.songs[i].artist) +
      "," + connection.escape(name) +
      ") AS tmp WHERE NOT EXISTS (SELECT song FROM songlist WHERE song = " +
      connection.escape(musicList.songs[i].title) +
      " AND artist = " + connection.escape(musicList.songs[i].artist) +
      " AND station = " + connection.escape(name) +
      " AND create_dttm >= NOW() - INTERVAL 10 MINUTE) LIMIT 1; ";

      connection.query(upsertQueries, function(error,
        results, fields) {
          if (error) _error += error + " || ";
        });
      }
      connection.end();
    });
    if (_error.length > 0) {
      console.log("ERROR: ", _error);
    } else {
      console.log("Function Complete!");
    }
  }


  app.use(express.static(__dirname + '/public'))
  .use(cookieParser());

  app.get('/login', function(req, res) {

    var state = generateRandomString(16);
    res.cookie(stateKey, state);

    // your application requests authorization
    var scope =
    'user-read-private user-read-email playlist-modify-public playlist-modify-private';
    res.redirect('https://accounts.spotify.com/authorize?' +
    querystring.stringify({
      response_type: 'code',
      client_id: client_id,
      scope: scope,
      redirect_uri: redirect_uri,
      state: state
    }));
  });

  app.get('/callback', function(req, res) {

    // your application requests refresh and access tokens
    // after checking the state parameter

    var code = req.query.code || null;
    var state = req.query.state || null;
    var storedState = req.cookies ? req.cookies[stateKey] : null;

    if (state === null || state !== storedState) {
      res.redirect('/#' +
      querystring.stringify({
        error: 'state_mismatch'
      }));
    } else {
      res.clearCookie(stateKey);
      var authOptions = {
        url: 'https://accounts.spotify.com/api/token',
        form: {
          code: code,
          redirect_uri: redirect_uri,
          grant_type: 'authorization_code'
        },
        headers: {
          'Authorization': 'Basic ' + (new Buffer(client_id + ':' +
          client_secret).toString('base64'))
        },
        json: true
      };

      request.post(authOptions, function(error, response, body) {
        if (!error && response.statusCode === 200) {

          _access_token = body.access_token;
          _refresh_token = body.refresh_token;

          var options = {
            url: 'https://api.spotify.com/v1/me',
            headers: {
              'Authorization': 'Bearer ' + _access_token
            },
            json: true
          };

          // use the access token to access the Spotify Web API
          request.get(options, function(error, response, body) {
            console.log(body);
          });

          // we can also pass the token to the browser to make requests from there
          res.redirect('/#' +
          querystring.stringify({
            access_token: _access_token,
            refresh_token: _refresh_token
          }));
        } else {
          res.redirect('/#' +
          querystring.stringify({
            error: 'invalid_token'
          }));
        }
      });
    }
  });

  app.get('/refresh_token', function(req, res) {

    // requesting access token from refresh token
    _refresh_token = req.query.refresh_token;
    var authOptions = {
      url: 'https://accounts.spotify.com/api/token',
      headers: {
        'Authorization': 'Basic ' + (new Buffer(client_id + ':' +
        client_secret).toString('base64'))
      },
      form: {
        grant_type: 'refresh_token',
        refresh_token: _refresh_token
      },
      json: true
    };

    request.post(authOptions, function(error, response, body) {
      if (!error && response.statusCode === 200) {
        _access_token = body.access_token;
        res.send({
          'access_token': _access_token
        });
      }
    });
  });


  app.listen('8888');
  (function() {
    refreshToken();
  })();

  console.log('Magic happens on port 8888');
