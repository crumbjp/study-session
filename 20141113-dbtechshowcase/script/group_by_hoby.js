printjson(
  db.people.aggregate([
   { $match: { sex: 'male' }},
   { $project: { hobies: 1, count:{ $literal: 1 }}},
   { $unwind: "$hobies" },
   { $group: {_id: "$hobies", count: { $sum: "$count" }}},
   { $sort: { count: 1 } },
  ]).toArray()
);


/*
  { "_id" : 1, "family" : "Henschel", "first" : "Arvind", "sex" : "male", "hobies" : [ "chinema", "TV" ] }
  { "_id" : 2, "family" : "Head", "first" : "Ginevra", "sex" : "female", "hobies" : [ "TV", "football", "swim" ] }
  { "_id" : 3, "family" : "Konchesky", "first" : "Gauvain", "sex" : "male", "hobies" : [ "TV", "tenis" ] }
$match
  { "_id" : 1, "family" : "Henschel", "first" : "Arvind", "sex" : "male", "hobies" : [ "chinema", "TV" ] }
  { "_id" : 3, "family" : "Konchesky", "first" : "Gauvain", "sex" : "male", "hobies" : [ "TV", "tenis" ] }
$project
  { "hobies" : [ "chinema",  "TV" ], "count" : 1 }
  { "hobies" : [ "TV", "tenis" ], "count" : 1 }
$rewind
  { "hobies" : "chinema", "count" : 1 }
  { "hobies" : "TV", "count" : 1 }
  { "hobies" : "TV", "count" : 1 }
  { "hobies" : "tenis", "count" : 1 }
$group
  { "_id" : "chinema", "count" : 1 }
  { "_id" : "TV", "count" : 2 }
  { "_id" : "tenis", "count" : 1 }
$sort
  { "_id" : "chinema", "count" : 1 }
  { "_id" : "tenis", "count" : 1 }
  { "_id" : "TV", "count" : 2 }
*/
