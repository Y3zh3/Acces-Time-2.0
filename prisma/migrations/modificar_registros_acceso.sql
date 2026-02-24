-- Modificar la tabla registros_acceso para registrar entrada/salida en una sola fila

USE accesstime;

-- 1. Agregar nueva columna para hora de salida (nullable)
ALTER TABLE registros_acceso 
ADD COLUMN hora_salida DATETIME(3) NULL AFTER fecha_hora;

-- 2. Renombrar fecha_hora a hora_entrada
ALTER TABLE registros_acceso 
CHANGE COLUMN fecha_hora hora_entrada DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- 3. Eliminar la columna accion (ya no se necesita)
ALTER TABLE registros_acceso 
DROP COLUMN accion;

-- 4. Agregar índice para userDni para búsquedas rápidas
ALTER TABLE registros_acceso 
ADD INDEX idx_dni_usuario (dni_usuario);

-- 5. Limpiar registros antiguos (opcional - descomentar si quieres empezar de cero)
-- TRUNCATE TABLE registros_acceso;

SELECT 'Migración completada: Tabla registros_acceso actualizada para entrada/salida en una fila' AS resultado;
