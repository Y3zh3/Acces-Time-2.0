-- Script para completar la migración a español
-- Algunas tablas ya están renombradas: empleados, biometricos_faciales

-- PASO 1: Eliminar foreign keys existentes
ALTER TABLE `access_logs` DROP FOREIGN KEY `access_logs_employeeId_fkey`;
ALTER TABLE `access_logs` DROP FOREIGN KEY `access_logs_transportId_fkey`;
ALTER TABLE `biometricos_faciales` DROP FOREIGN KEY `face_biometrics_employeeId_fkey`;
ALTER TABLE `biometricos_faciales` DROP FOREIGN KEY `face_biometrics_providerPersonnelId_fkey`;
ALTER TABLE `biometricos_faciales` DROP FOREIGN KEY `face_biometrics_transportPersonnelId_fkey`;
ALTER TABLE `temporary_passes` DROP FOREIGN KEY `temporary_passes_issuedById_fkey`;

-- PASO 2: Renombrar tablas pendientes
ALTER TABLE `transport_personnel` RENAME TO `personal_transporte`;
ALTER TABLE `provider_companies` RENAME TO `empresas_proveedoras`;
ALTER TABLE `provider_personnel` RENAME TO `personal_proveedores`;
ALTER TABLE `access_logs` RENAME TO `registros_acceso`;
ALTER TABLE `temporary_passes` RENAME TO `pases_temporales`;

-- PASO 3: Renombrar columnas de empleados (si aún no están renombradas)
ALTER TABLE `empleados` 
  CHANGE COLUMN `fullName` `nombre_completo` VARCHAR(255),
  CHANGE COLUMN `role` `rol` ENUM('ADMINISTRADOR', 'SUPERVISOR', 'EMPLEADO', 'SEGURIDAD', 'PROVEEDOR', 'TRANSPORTE', 'RRHH', 'AUDITOR') DEFAULT 'EMPLEADO',
  CHANGE COLUMN `department` `departamento` VARCHAR(100),
  CHANGE COLUMN `contractExpiry` `vencimiento_contrato` DATETIME,
  CHANGE COLUMN `photoPath` `ruta_foto` VARCHAR(500),
  CHANGE COLUMN `status` `estado` VARCHAR(50) DEFAULT 'Activo',
  CHANGE COLUMN `hasBiometric` `tiene_biometrico` BOOLEAN DEFAULT false,
  CHANGE COLUMN `workStartTime` `hora_entrada` VARCHAR(5) DEFAULT '08:00',
  CHANGE COLUMN `workEndTime` `hora_salida` VARCHAR(5) DEFAULT '17:45',
  CHANGE COLUMN `entryDateTime` `fecha_hora_entrada` DATETIME,
  CHANGE COLUMN `exitDateTime` `fecha_hora_salida` DATETIME,
  CHANGE COLUMN `createdAt` `creado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- PASO 4: Renombrar columnas de biometricos_faciales
ALTER TABLE `biometricos_faciales`
  CHANGE COLUMN `employeeId` `empleado_id` INT,
  CHANGE COLUMN `transportPersonnelId` `personal_transporte_id` INT,
  CHANGE COLUMN `providerPersonnelId` `personal_proveedor_id` INT,
  CHANGE COLUMN `isActive` `activo` BOOLEAN DEFAULT true,
  CHANGE COLUMN `createdAt` `creado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- PASO 5: Renombrar columnas de personal_transporte
ALTER TABLE `personal_transporte`
  CHANGE COLUMN `fullName` `nombre_completo` VARCHAR(255),
  CHANGE COLUMN `company` `empresa` VARCHAR(255),
  CHANGE COLUMN `vehicle` `vehiculo` VARCHAR(100),
  CHANGE COLUMN `licensePlate` `matricula` VARCHAR(20),
  CHANGE COLUMN `photoPath` `ruta_foto` VARCHAR(500),
  CHANGE COLUMN `status` `estado` VARCHAR(50) DEFAULT 'Activo',
  CHANGE COLUMN `workStartTime` `hora_entrada` VARCHAR(5) DEFAULT '08:00',
  CHANGE COLUMN `workEndTime` `hora_salida` VARCHAR(5) DEFAULT '17:45',
  CHANGE COLUMN `entryDateTime` `fecha_hora_entrada_programada` DATETIME,
  CHANGE COLUMN `exitDateTime` `fecha_hora_salida_programada` DATETIME,
  CHANGE COLUMN `actualEntryDateTime` `fecha_hora_entrada_real` DATETIME,
  CHANGE COLUMN `actualExitDateTime` `fecha_hora_salida_real` DATETIME,
  CHANGE COLUMN `createdAt` `creado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- PASO 6: Renombrar columnas de empresas_proveedoras
ALTER TABLE `empresas_proveedoras`
  CHANGE COLUMN `companyName` `nombre_empresa` VARCHAR(255),
  CHANGE COLUMN `supplyType` `tipo_suministro` VARCHAR(100),
  CHANGE COLUMN `commercialContact` `contacto_comercial` VARCHAR(255),
  CHANGE COLUMN `phone` `telefono` VARCHAR(50),
  CHANGE COLUMN `address` `direccion` VARCHAR(500),
  CHANGE COLUMN `status` `estado` VARCHAR(50) DEFAULT 'Activo',
  CHANGE COLUMN `createdAt` `creado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- PASO 7: Renombrar columnas de personal_proveedores
ALTER TABLE `personal_proveedores`
  CHANGE COLUMN `fullName` `nombre_completo` VARCHAR(255),
  CHANGE COLUMN `company` `empresa` VARCHAR(255),
  CHANGE COLUMN `position` `cargo` VARCHAR(100),
  CHANGE COLUMN `phone` `telefono` VARCHAR(50),
  CHANGE COLUMN `photoPath` `ruta_foto` VARCHAR(500),
  CHANGE COLUMN `status` `estado` VARCHAR(50) DEFAULT 'Activo',
  CHANGE COLUMN `workStartTime` `hora_entrada` VARCHAR(5) DEFAULT '08:00',
  CHANGE COLUMN `workEndTime` `hora_salida` VARCHAR(5) DEFAULT '17:45',
  CHANGE COLUMN `entryDateTime` `fecha_hora_entrada_programada` DATETIME,
  CHANGE COLUMN `exitDateTime` `fecha_hora_salida_programada` DATETIME,
  CHANGE COLUMN `actualEntryDateTime` `fecha_hora_entrada_real` DATETIME,
  CHANGE COLUMN `actualExitDateTime` `fecha_hora_salida_real` DATETIME,
  CHANGE COLUMN `createdAt` `creado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- PASO 8: Renombrar columnas de registros_acceso
ALTER TABLE `registros_acceso`
  CHANGE COLUMN `userName` `nombre_usuario` VARCHAR(255),
  CHANGE COLUMN `userDni` `dni_usuario` VARCHAR(20),
  CHANGE COLUMN `role` `rol` VARCHAR(100),
  CHANGE COLUMN `status` `estado` VARCHAR(50),
  CHANGE COLUMN `action` `accion` VARCHAR(255),
  CHANGE COLUMN `zone` `zona` VARCHAR(100),
  CHANGE COLUMN `type` `tipo` VARCHAR(50),
  CHANGE COLUMN `timestamp` `fecha_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN `employeeId` `empleado_id` INT,
  CHANGE COLUMN `transportId` `transporte_id` INT;

-- PASO 9: Renombrar columnas de pases_temporales
ALTER TABLE `pases_temporales`
  CHANGE COLUMN `fullName` `nombre_completo` VARCHAR(255),
  CHANGE COLUMN `company` `empresa` VARCHAR(255),
  CHANGE COLUMN `reason` `motivo` TEXT,
  CHANGE COLUMN `authorizedBy` `autorizado_por` VARCHAR(255),
  CHANGE COLUMN `issuedById` `emitido_por_id` INT,
  CHANGE COLUMN `validFrom` `valido_desde` DATETIME,
  CHANGE COLUMN `validUntil` `valido_hasta` DATETIME,
  CHANGE COLUMN `status` `estado` VARCHAR(50) DEFAULT 'Activo',
  CHANGE COLUMN `createdAt` `creado_en` DATETIME DEFAULT CURRENT_TIMESTAMP;

-- PASO 10: Recrear foreign keys con los nuevos nombres
ALTER TABLE `biometricos_faciales`
  ADD CONSTRAINT `biometricos_faciales_empleado_id_fkey` 
    FOREIGN KEY (`empleado_id`) REFERENCES `empleados`(`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `biometricos_faciales_personal_transporte_id_fkey` 
    FOREIGN KEY (`personal_transporte_id`) REFERENCES `personal_transporte`(`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `biometricos_faciales_personal_proveedor_id_fkey` 
    FOREIGN KEY (`personal_proveedor_id`) REFERENCES `personal_proveedores`(`id`) ON DELETE CASCADE;

ALTER TABLE `registros_acceso`
  ADD CONSTRAINT `registros_acceso_empleado_id_fkey` 
    FOREIGN KEY (`empleado_id`) REFERENCES `empleados`(`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `registros_acceso_transporte_id_fkey` 
    FOREIGN KEY (`transporte_id`) REFERENCES `personal_transporte`(`id`) ON DELETE SET NULL;

ALTER TABLE `pases_temporales`
  ADD CONSTRAINT `pases_temporales_emitido_por_id_fkey` 
    FOREIGN KEY (`emitido_por_id`) REFERENCES `empleados`(`id`) ON DELETE SET NULL;

SELECT 'Migración completada exitosamente' AS resultado;
