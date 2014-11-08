SELECT
  COUNT(people._id)
FROM
  people
INNER JOIN
  hobies
ON
  people._id = hobies._pid
WHERE
  hobies.name = 'TV';
