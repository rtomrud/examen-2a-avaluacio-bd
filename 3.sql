SELECT
  department_name,
  COALESCE(street_address, '') ||
  (CASE WHEN street_address IS NOT NULL THEN ', ' ELSE '' END) ||
  COALESCE(city, '') ||
  (CASE WHEN city IS NOT NULL THEN ', ' ELSE '' END) ||
  COALESCE(state_province, '') ||
  (CASE WHEN state_province IS NOT NULL THEN ', ' ELSE '' END) ||
  COALESCE(postal_code, '') ||
  (CASE WHEN postal_code IS NOT NULL THEN ', ' ELSE '' END) ||
  COALESCE(country_name, '') AS address
FROM
  departments
JOIN
  locations ON departments.location_id = locations.location_id
JOIN
  countries ON locations.country_id = countries.country_id;
