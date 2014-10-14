var mysql = require('mysql')

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'tokushima'
});

function getOne(callback) {
  connection.query('SELECT * FROM introduction LIMIT 1', function (err, introductions) {
		if (err) throw err;
		var introduction = introductions[0];
		connection.query('SELECT * FROM activities WHERE _introduction_id = ?', introduction._id, function (err, activities) {
			if (err) throw err;
			introduction.activities = {};
			for( var i in activities) {
				introduction.activities[activities[i].name] = activities[i].url;
			}
			introduction._queries = [
				'SELECT * FROM introduction LIMIT 1;',
				'SELECT * FROM activities WHERE _introduction_id = ?;'
			];
			callback(introduction);
		});
  });
}

exports.getOne = getOne;
