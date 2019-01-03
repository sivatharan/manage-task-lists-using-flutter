'use strict';
var db = require('../../database/'+config.enabledDb+'/list')
var List = require('./class')
var list = new List();

exports.add = function (req, res, next) {
	console.info('-----------add-----------')
	// list.validatListBody(req);
	// var reqBodyResult = appFun.reqBodyValidation(req, res);
	// if(reqBodyResult != null)  return res.status(400).json({status: false, message: "failed", result: reqBodyResult});
	console.info(req.body)
	db.add(req.body,function(err,result){
		if(err){
			return res.status(400).json({status: false, message: "failed", result:'Somthing went wrong'});
		}
		return res.status(200).json({status: true, message: "success", result: 'Successfully Added'});
		
	});
}

exports.update = function (req, res, next) {
	console.info('-----------update-----------')
	// console.info('---update---',req.body)
	// console.info(req.params)
	// list.validatListBody(req);
	// var reqBodyResult = appFun.reqBodyValidation(req, res);
	// if(reqBodyResult != null)  return res.status(400).json({status: false, message: "failed", result: reqBodyResult});
	var data =  req.body;
	data.id = req.params.id;
	db.update(data, function(err,result){
		if(err){
			return res.status(400).json({status: false, message: "failed", result:result});
		}
		return res.status(200).json({status: true, message: "success", result: 'Successfully Updated'});
		
	});
}

exports.get = function (req, res, next) {
	// console.info('-----------get-----------')

	var reqBodyResult = appFun.reqBodyValidation(req, res);
	if(reqBodyResult != null)  return res.status(400).json({status: false, message: "failed", result: reqBodyResult});

	db.get(req.params.id, function(err,result){
		// console.info(result);
		if(err){
			return res.status(400).json({status: false, message: "failed", result:result});
		}
		console.info(result);
		return res.status(200).json({status: true, message: "success", result: result});
	});
	
}



exports.delete = function (req, res, next) {

	// user.validateEmailLoginBody(req);
	// var reqBodyResult = appFun.reqBodyValidation(req, res);
	// if(reqBodyResult != null)  return res.status(400).json({status: false, message: "failed", result: reqBodyResult});

	db.delete(req.params.id, function(err,result){
		// console.info(result);
		if(err){
			return res.status(400).json({status: false, message: "failed", result:result});
		}
		return res.status(200).json({status: true, message: "success", result: 'Successfully Deleted'});
	});
	
}


