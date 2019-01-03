class List {

	constructor() {
	}

	validatListBody(req,res) { // login body param validation
		req.checkBody('name', 'Invalid name').notEmpty().withMessage("name can not be empty");
	}

}

  module.exports= List;