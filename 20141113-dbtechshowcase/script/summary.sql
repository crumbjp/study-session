SELECT
  hoby_count,
  COUNT(pid)
FROM
(
  SELECT
    people._id AS pid,
    COUNT(name) AS hoby_count
  FROM
    people
  INNER JOIN
    hobies
  ON
    people._id = hobies._pid
  WHERE
    people.sex = 'male'
  GROUP BY
    hobies._pid
) hoby_count_per_person
GROUP BY
  hoby_count
ORDER BY
  COUNT(pid)
;
