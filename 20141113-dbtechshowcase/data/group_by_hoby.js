printjson(
  db.people.aggregate([
   { $match: { sex: 'male' }},
   { $project: { hobies: 1, count:{ $literal: 1 }}},
   { $unwind: "$hobies" },
   { $group: {_id: "$hobies", count: { $sum: "$count" }}},
   { $sort: { count: 1 } },
  ]).toArray()
);
