'use strict';
var bodyParser = require('body-parser'),
    assert = require('assert'),
    expressValidator = require('express-validator'),
    cors=require('cors'),
    useragent = require('express-useragent');

module.exports = function(app) {

    app.use(bodyParser.json({ limit: '50mb' })); //maximum request body size
    app.use(expressValidator([])); // body param validator
    app.use(bodyParser.urlencoded(
        {limit: '50mb', extended: true}
    ));
    app.use(useragent.express());
    
    app.use(function (req, res, next) {
        res.setHeader('Access-Control-Allow-Origin', '*'); // Website you wish to allow to connect
        res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');  // Request methods you wish to allow
        res.setHeader('Access-Control-Allow-Headers', 'Origin, Accept,X-Requested-With,content-type,Authorization'); // Request headers you wish to allow
        res.setHeader('Access-Control-Allow-Credentials', true);  // Set to true if you need the website to include cookies in the requests sent , to the API (e.g. in case you use sessions)
        next();  // Pass to next layer of middleware
    });

    app.use(function (error, req, res, next) { // Caught the syntax error
        if (error instanceof SyntaxError) {
            res.status(400).json({status: false, message: "failed", result: "Syntax Error"});
        } else {
        next();
        }
    });

    // app.all('/api/v1/app/*',[require('./validateRequest')]); // all auth validation

    require('./route')(app);// all routing here

    // app.post('/api/v1/app/verify_auth', function(req, res){ //tesing 
    //     res.status(404).json({status: true, message: "success", result: true});
    // });

	app.all('*', function(req, res){  //entered incorrect get url
	  	res.status(404).json({status: false, message: "failed", result: 'Please check your method or url'});
    });
	// app.post('*', function(req, res){ //entered incorrect post url
	//  	res.status(404).json({status: false, message: "failed", result: 'Please check your method or url'});
    // });    

}