var express = require('express');
var by_mongo = require('../models/introduction_by_mongo');
var by_mysql = require('../models/introduction_by_mysql');
var router = express.Router();
/* GET home page. */
router.get('/by_mongo', function(req, res) {
	by_mongo.getOne( function(doc) {
		res.render('introduction', {doc: doc});
	});
});

router.get('/by_mysql', function(req, res) {
	by_mysql.getOne( function(doc) {
		res.render('introduction', {doc: doc});
	});
});

module.exports = router;
