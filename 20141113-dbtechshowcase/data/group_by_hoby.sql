SELECT
  hobies.name,
  COUNT(people._id)
FROM
  people
INNER JOIN
  hobies
ON
  people._id = hobies._pid
WHERE
  people.sex = 'male'
GROUP BY
  hobies.name
ORDER BY
  COUNT(people._id)
;
