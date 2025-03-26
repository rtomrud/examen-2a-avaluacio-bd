-- Mostra el número d'empleats de cada departament.
SELECT
  department_name,
  COUNT(employee_id) AS num_employees
FROM
  departments
  LEFT JOIN employees ON departments.department_id = employees.department_id
GROUP BY
  department_name
ORDER BY
  department_name;
