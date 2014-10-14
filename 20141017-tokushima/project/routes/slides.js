var express = require('express');
var router = express.Router();

var mongolian = require('mongolian')
var server = new mongolian('127.0.0.1:27017')
var db = server.db('tokushima')
var collection = db.collection('slides')

/* GET users listing. */
router.get('/', function(req, res) {
	collection
		.find({}, {_id: 1, title: 1})
		.sort({page: 1})
		.toArray(function(err, slides){
			if (err) throw err;
			res.render('slides/index.ejs', {slides: slides});
	});
});

router.get('/:_id', function(req, res) {
	collection
		.findOne({_id: new mongolian.ObjectId(req.params._id)}, function(err, slide){
			if (err) throw err;
			res.render('slides/show.ejs', {slide: slide});
	});

});


module.exports = router;
