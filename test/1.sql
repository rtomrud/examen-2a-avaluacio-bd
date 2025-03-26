-- Mostra el nom, cognom i departament dels empleats que tenen el mateix nom que un altre empleat.
SELECT
  first_name,
  last_name,
  department_name
FROM
  employees
  JOIN departments ON employees.department_id = departments.department_id
WHERE
  first_name IN (
    SELECT
      first_name
    FROM
      employees
    GROUP BY
      first_name
    HAVING
      COUNT(*) > 1
  )
ORDER BY
  last_name;
