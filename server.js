var express = require('express');
var fs = require('fs');
var request = require('request');
var cheerio = require('cheerio');
var app = express();

app.get('/scrape', function(req, res) {
    url = 'http://krbz.tunegenie.com/';
	var musicList = {};
	var songs = [];
	
	musicList.songs = songs;
		
	
    request(url, function(error, response, html){


        if(!error){
            var $ = cheerio.load(html);
            var title, artist, song;
			var count = 0;

			// The songs are located in 2 spots. Use hidden on open to only get 1 result per song
            $('.hidden-on-open .song').filter(function(){
                var data = $(this);
				
				// Get the title from the .song div
                title = data.text().trim();
				console.log('Title: ', title);
				
				// artist is in the next div, which has no class
				artist = data.next().text().trim();
				console.log('Artist: ', artist);
				
				// build the song
				song = {
					"title" : title,
					"artist" : artist
				}
				
				console.log('Song: ', song);
				
				// add the song to the list of songs
				musicList.songs.push(song);
				
            });
			
			console.log(musicList);
        }
		
		
	fs.writeFile('output.json', JSON.stringify(musicList), function(err){

		console.log('File successfully written! - Check your project directory for the output.json file');

	});
	res.send('Check your console!')

		});

		
		
    })
	

app.listen('8081'); 
console.log('Magic happens on port 8081'); 
exports = module.exports = app;