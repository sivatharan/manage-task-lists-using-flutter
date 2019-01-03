module.exports = {
    validation: function(value) {
        if (value == '' || value == undefined){
            return true
        }
    },
    jwt:{
        secret:"siva",
        expiresIn: 30*60
    },

    log: function(message) {

        var filename = './log/node-' + moment().format('YYYY-MM-DD') + '.log';
        var content =  moment().format('YYYY-MM-DD') + ' - ' + message +' \n\n'

        fs.stat(filename, function(err, stat) {

            if(err == null) {
                fs.appendFile(filename, content, (err) => {
                    //if (err) throw err;
                });
            } else if(err.code === 'ENOENT') {
                // file does not exist
                fs.writeFile(filename, content, (err) => {
                    // if (err) throw err;
                });
            } else {
                console.log('Some other error: ', err.code);
            }
        });
    },
}