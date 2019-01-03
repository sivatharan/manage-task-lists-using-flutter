var router = express.Router();
var controll = require('./controller');

router.post('/',controll.add);
router.post('/login',controll.login);
module.exports=router;