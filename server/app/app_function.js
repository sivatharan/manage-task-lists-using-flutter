/*common function here*/
var password_hash = require('password-hash');
var jwt = require('jsonwebtoken');
var crypto = require('crypto');

exports.isInt = function(n){
    return Number(n) === n && n % 1 === 0;
}

exports.isFloat   = function(n){
	// console.info('----',n);
	n = parseFloat(n);
    return Number(n) === n && n % 1 !== 0;
}

exports.isString = function(s){
	if(s.length == 0) return false;
	return typeof s === 'string' || s instanceof String;
}

exports.getDate = function(dt){

	var year = dt.getFullYear();
	var month = dt.getMonth() + 1;
	if(month <= 9) month = '0'+month;

	var day= dt.getDate();
	if(day <= 9) day = '0'+day;

	var prettyDate = year +'-'+ month +'-'+ day;
	return prettyDate;
	
}

exports.getTime = function(dt){
	var h = (dt.getHours()<10?'0':'') + dt.getHours(),
        m = (dt.getMinutes()<10?'0':'') + dt.getMinutes();
	return h + ':' + m;
}

exports.isObject = function(a) {
    return (!!a) && (a.constructor === Object);
};

exports.isArray = function(a) {
    return (!!a) && (a.constructor === Array);
};

exports.contentType = function(req){
	if(req.get('Content-Type') == 'application/json') return 'json'
	else return 'others'
};


exports.getTimeDiff = function(start,end,message){
 	var seconds = (end.getTime() - start.getTime()) / 1000;
   console.info("--"+message+"---",seconds);
}

exports.reqBodyValidation = function(req){ // request body full valiation here
	var errors = req.validationErrors();
	if(appFun.contentType(req) != 'json') {
		return  'Content type must be json';
	}	   
	if (errors){
		return  errors;
	}
	return null;
}

exports.trimAndLovercase = function(str){
	return str.toLowerCase().trim();
}


exports.encryptPassword = function(str){
    return password_hash.generate(str);
}

exports.passwordVerify = function(pw,db_pw){
    return password_hash.verify(pw , db_pw);
}

exports.jwtToken = function(user) {

	return jwt.sign({
		id: user.id,
		verify : appFun.encriptString(user.browser)+'.'+appFun.encriptString(user.ip)
	}, 
		globalJs.jwt.secret, 
	{
		expiresIn: globalJs.jwt.expiresIn
	});
}

exports.verifyToken = function(req, cb) {
	var st = new Date();
	var token = req.headers.token !=undefined?req.headers.token:'';
	jwt.verify(req.headers.token, globalJs.jwt.secret, function(err, decoded) {
		// console.info(err.JsonWebTokenError);
		// appFun.getTimeDiff(st,new Date());
		if(err) return cb(true, err.message)
		return  cb(false, decoded)
	});
}

exports.encriptString = function(str) {
	const hmac = crypto.createHmac('sha256', str);
	return hmac.digest('hex');
	 
}

exports.findUseragent = function(req){
	var obj = {}
	obj.browser = req.useragent.browser;	
	obj.browserVersion = req.useragent.version;
	obj.ip = req.ip;
	obj.location = '';
	return obj;
}

exports.dateNow = function(){
	var dateNow = new Date();
	return dateNow;
}