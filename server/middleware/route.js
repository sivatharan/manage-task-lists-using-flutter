
'use strict';
module.exports = function(app) {
    // app.all('/api/v1/*', [require('./middlewares/validateRequest')]);
    app.use( config.baseUrl + '/list', require('../api/list/index')); //task related Api
    app.use( config.baseUrl + '/user', require('../api/user/index')); //user related Api
}