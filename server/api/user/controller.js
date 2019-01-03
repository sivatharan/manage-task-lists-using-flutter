'use strict';
var db = require('../../database/'+config.enabledDb+'/user')
const passwordHash = require('password-hash');

exports.add = function (req, res, next) {
	// list.validatListBody(req);
	// var reqBodyResult = appFun.reqBodyValidation(req, res);
	// if(reqBodyResult != null)  return res.status(400).json({status: false, message: "failed", result: reqBodyResult});
	// console.info(req.body);
	var data = req.body;
	data.password = passwordHash.generate(req.body.password);

	db.add(req.body,function(err,result){
		console.info(result)
		if(err){
			return res.status(400).json({status: false, message: "failed", result:'user name is exist.try with defferent user name'});
		}
		return res.status(200).json({status: true, message: "success", result: 'Successfully Added'});
		
	});
}

exports.login = function (req, res, next) {
	// console.info('---update---',req.body)
	// console.info(req.params)
	// list.validatListBody(req);
	// var reqBodyResult = appFun.reqBodyValidation(req, res);
	// if(reqBodyResult != null)  return res.status(400).json({status: false, message: "failed", result: reqBodyResult});
	db.login(req.body, function(err,result){
		if(err){
			return res.status(400).json({status: false, message: "failed", result:result});
		}else{

			if(result.length < 1) return res.status(404).json({status: false,message:"faild",result: "username is wrong"});

		  	if(!passwordHash.verify(req.body.password, result[0].password)) return res.status(404).json({status: false,message:"faild",result: "password is wrong"});
			var data = result[0];
			delete data.password;
			delete data.created_date;
			delete data.updated_date;
			return res.status(200).json({status: true, message: "success", result: data});
		}
		
	});
}
