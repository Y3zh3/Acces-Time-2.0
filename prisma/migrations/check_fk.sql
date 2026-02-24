-- Paso 1: Consultar foreign keys existentes
SELECT 
  TABLE_NAME as tabla,
  CONSTRAINT_NAME as constraint_nombre,
  COLUMN_NAME as columna,
  REFERENCED_TABLE_NAME as tabla_referenciada
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_SCHEMA = 'accesstime' 
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;
