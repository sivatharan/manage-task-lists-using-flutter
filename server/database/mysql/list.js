var db = require('./connection');

exports.add = function (data,cb) {
    var startDate = new Date();
    var queryString = "insert into list set ?";
    
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

exports.update = function (data,cb) {
    console.info(data);
    var startDate = new Date();
    var queryString = "update list set name = '"+data.name+"',priority = '"+data.priority+"',description = '"+data.description+"' ,due_date = '"+data.due_date+"' where id ="+data.id;
    
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

exports.get = function (id,cb) {
    var startDate = new Date();
    var queryString = "select * from list where user_id="+parseInt(id);;
    
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

exports.delete = function (id,cb) {
    var startDate = new Date();
    var queryString = "delete from list where id="+id;
    
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
