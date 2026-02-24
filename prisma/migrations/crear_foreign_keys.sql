-- Crear foreign keys en español

-- Foreign keys para biometricos_faciales
ALTER TABLE `biometricos_faciales`
  ADD CONSTRAINT `biometricos_faciales_empleado_id_fkey` 
    FOREIGN KEY (`empleado_id`) REFERENCES `empleados`(`id`) ON DELETE CASCADE;

ALTER TABLE `biometricos_faciales`
  ADD CONSTRAINT `biometricos_faciales_personal_transporte_id_fkey` 
    FOREIGN KEY (`personal_transporte_id`) REFERENCES `personal_transporte`(`id`) ON DELETE CASCADE;

ALTER TABLE `biometricos_faciales`
  ADD CONSTRAINT `biometricos_faciales_personal_proveedor_id_fkey` 
    FOREIGN KEY (`personal_proveedor_id`) REFERENCES `personal_proveedores`(`id`) ON DELETE CASCADE;

-- Foreign keys para registros_acceso
ALTER TABLE `registros_acceso`
  ADD CONSTRAINT `registros_acceso_empleado_id_fkey` 
    FOREIGN KEY (`empleado_id`) REFERENCES `empleados`(`id`) ON DELETE SET NULL;

ALTER TABLE `registros_acceso`
  ADD CONSTRAINT `registros_acceso_transporte_id_fkey` 
    FOREIGN KEY (`transporte_id`) REFERENCES `personal_transporte`(`id`) ON DELETE SET NULL;

-- Foreign keys para pases_temporales
ALTER TABLE `pases_temporales`
  ADD CONSTRAINT `pases_temporales_emitido_por_id_fkey` 
    FOREIGN KEY (`emitido_por_id`) REFERENCES `empleados`(`id`) ON DELETE SET NULL;

SELECT 'Foreign keys creadas exitosamente' AS resultado;
