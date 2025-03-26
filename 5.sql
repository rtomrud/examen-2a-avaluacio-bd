(
  SELECT
    first_name,
    last_name,
    salary
  FROM
    employees
  ORDER BY
    salary DESC
  LIMIT
    1
)
UNION
(
  SELECT
    first_name,
    last_name,
    salary
  FROM
    employees
  ORDER BY
    salary ASC
  LIMIT
    1
)
ORDER BY
  salary DESC;
