var jwt = require('jsonwebtoken');


module.exports = function(req, res, next) {
    // console.info(req.useragent)
    appFun.verifyToken(req,function(err,result){
        if(err) return res.status(400).json({status: false, message: "failed", result:result});        
        else if(result.verify != appFun.encriptString(req.useragent.browser+'_'+req.useragent.version)+'.'+appFun.encriptString(req.ip)) return res.status(400).json({status: false, message: "failed", result:'Invalid Access'});
        else next();
        //TODO::database validation
    });
};


