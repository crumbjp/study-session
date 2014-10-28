printjson(
  db.people.aggregate([
   { $project: {count: {$literal: 1}, numhobies: { $size: "$hobies" } } },
   { $group: {_id: "$numhobies", count: { $sum: "$count" } } },
   { $sort: { count: 1 } },
  ]).toArray()
);

