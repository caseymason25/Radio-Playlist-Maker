'use strict';

let express = require('express');
let fs = require('fs');
let request = require('request');
let cheerio = require('cheerio');
let app = express();
let mysql = require('mysql');
let schedule = require('node-schedule');

var querystring = require('querystring');
var cookieParser = require('cookie-parser');

var client_id = '641daa3d66fd465caf3f1c8502d393aa'; // Your client id
var client_secret = '636653ffc01a4974a1a7dbdba6e73415'; // Your secret
var redirect_uri = 'http://localhost:8888/callback'; // Your redirect uri

let _refresh_token = false;
let _access_token = false;


var theBuzz = schedule.scheduleJob('*/15 * * * * *', function() {
  parseWebsite("965 The Buzz", "http://krbz.tunegenie.com/");
});

var spotify = schedule.scheduleJob('*/5 * * * *', function() {
  refreshToken();
});

var spotifySong = schedule.scheduleJob('*/6 * * * * *', function() {
  getSpotifySong();
});


function getSpotifySong() {
  // requesting access token from refresh token
  let _url = "https://api.spotify.com/v1/search?q=track:Agnes%20artist:Glass%20Animals&type=track";
  var authOptions = {
    url: _url,
    headers: {
      'Authorization': 'Bearer ' + _access_token
    }
  };

  request.get(authOptions, function(error, response, body) {
    if (!error && response.statusCode === 200) {
      let _tracks = JSON.parse(body).tracks;

      for (let i = 0; i < _tracks.items.length; i++) {
        console.log("Number ", i, ": ");
        console.log(_tracks.items[i].name);
        console.log(_tracks.items[i].artists[0].name);
        console.log(_tracks.items[i].uri);
        console.log(" ");
      }

    } else {
      console.log("body: ", body);
    }
  });

  // q=track:Agnes%20artist:Glass%20Animals&type=track
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
      console.log("Token Refreshed: ", _refresh_token);
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


      let upsertQueries = "INSERT INTO songlist (song,artist,station) SELECT * FROM (SELECT " + connection.escape(musicList.songs[i].title) + "," +
        connection
        .escape(musicList.songs[i].artist) +
        "," + connection.escape(name) + ") AS tmp WHERE NOT EXISTS (SELECT song FROM songlist WHERE song = " + connection.escape(musicList.songs[i].title) +
        " AND artist = " + connection.escape(musicList.songs[i].artist) + " AND station = " + connection.escape(name) +
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
  var scope = 'user-read-private user-read-email playlist-modify-public playlist-modify-private';
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
