'use strict';
global.express = require('express');
var app = express();
var http = require('http');

process.env.NODE_ENV = process.env.NODE_ENV || 'development'; // check the envirment

global.config = require('./config/config'); //all the configurations
global.appFun = require('./app/app_function');
global.globalJs = require('./config/global'); 

require('./middleware/express')(app); // all the rest api

app.listen(config.port,function(){ // server running status
	console.info('server is running on '+config.port);
});
