printjson(
  db.people.aggregate([
   { $project: {count: {$literal: 1}, numhobies: { $size: "$hobies" } } },
   { $group: {_id: "$numhobies", count: { $sum: "$count" } } },
   { $sort: { count: 1 } },
  ]).toArray()
);

/*
  { "_id" : 1, "family" : "Henschel", "first" : "Arvind", "sex" : "male", "hobies" : [ "chinema", "TV" ] }
  { "_id" : 2, "family" : "Head", "first" : "Ginevra", "sex" : "female", "hobies" : [ "TV", "football", "swim" ] }
  { "_id" : 3, "family" : "Konchesky", "first" : "Gauvain", "sex" : "male", "hobies" : [ "TV", "tenis" ] }
$project
  { "hobies" : "_id" : 2, "count" : 1 }
  { "hobies" : "_id" : 3, "count" : 1 }
  { "hobies" : "_id" : 2, "count" : 1 }
$group
  { "hobies" : "_id" : 2, "count" : 2 }
  { "hobies" : "_id" : 3, "count" : 1 }
$sort
  { "hobies" : "_id" : 3, "count" : 1 }
  { "hobies" : "_id" : 2, "count" : 2 }
*/
