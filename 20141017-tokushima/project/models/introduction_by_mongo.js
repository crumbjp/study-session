var mongolian = require('mongolian')
var server = new mongolian('127.0.0.1:27017')
var db = server.db('tokushima')
var collection = db.collection('introduction')

function getOne(callback) {
	collection.findOne({}, function(err, doc){
		if (err) throw err;
		doc._queries = ['db.introduction.findOne();'];
		callback(doc);
	});
}

exports.getOne = getOne;
