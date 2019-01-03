var router = express.Router();
var controll = require('./controller');

router.post('/',controll.add);
router.put('/:id',controll.update);
router.get('/:id',controll.get);
router.delete('/:id',controll.delete);

module.exports=router;