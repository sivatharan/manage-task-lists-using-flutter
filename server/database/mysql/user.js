var db = require('./connection');

exports.add = function (data,cb) {
    var startDate = new Date();
    data.username = data.username.trim();
    var queryString = "insert into user set ?";
    
    db.getConnection((err, connection)=>{
        if(err){  return cb(true, err); }
        connection.query(queryString, data,(err, result) =>{
            connection.release();
            if(err){
                return cb(true, err);
            }else{
                return cb(false, result);
            }
        });
    });
}

exports.login = function (data,cb) {
    
    var queryString = "select * from user where username='"+data.username+"'";
    
    db.getConnection((err, connection)=>{
        if(err){  return cb(true, err); }
        connection.query(queryString,(err, result) =>{
            connection.release();
            if(err){
                return cb(true, err);
            }else{
                return cb(false, result);
            }
        });
    });
}