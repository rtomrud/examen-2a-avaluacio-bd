-- Mostra el codi i nom dels països amb més empleats que la mitjana d'empleats per païs. 
SELECT
  countries.country_id,
  country_name,
  COUNT(employee_id) AS employee_count
FROM
  countries
  JOIN locations ON countries.country_id = locations.country_id
  JOIN departments ON locations.location_id = departments.location_id
  JOIN employees ON departments.department_id = employees.department_id
GROUP BY
  countries.country_id,
  country_name
HAVING
  COUNT(employee_id) > (
    SELECT
      AVG(employee_count)
    FROM
      (
        SELECT
          COUNT(employee_id) AS employee_count
        FROM
          employees
          JOIN departments ON employees.department_id = departments.department_id
          JOIN locations ON departments.location_id = locations.location_id
          JOIN countries ON locations.country_id = countries.country_id
        GROUP BY
          countries.country_id
      ) AS average_employee_count
  );
