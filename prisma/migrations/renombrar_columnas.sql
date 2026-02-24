-- Renombrar SOLO columnas (las tablas ya están en español)

-- Biometricos_faciales
ALTER TABLE `biometricos_faciales`
  CHANGE COLUMN `employeeId` `empleado_id` INT,
  CHANGE COLUMN `transportPersonnelId` `personal_transporte_id` INT,
  CHANGE COLUMN `providerPersonnelId` `personal_proveedor_id` INT,
  CHANGE COLUMN `isActive` `activo` TINYINT(1) DEFAULT 1,
  CHANGE COLUMN `createdAt` `creado_en` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME(3);

-- Personal_transporte
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
  CHANGE COLUMN `createdAt` `creado_en` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME(3);

-- Empresas_proveedoras
ALTER TABLE `empresas_proveedoras`
  CHANGE COLUMN `companyName` `nombre_empresa` VARCHAR(255),
  CHANGE COLUMN `supplyType` `tipo_suministro` VARCHAR(100),
  CHANGE COLUMN `commercialContact` `contacto_comercial` VARCHAR(255),
  CHANGE COLUMN `phone` `telefono` VARCHAR(50),
  CHANGE COLUMN `address` `direccion` VARCHAR(500),
  CHANGE COLUMN `status` `estado` VARCHAR(50) DEFAULT 'Activo',
  CHANGE COLUMN `createdAt` `creado_en` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
  CHANGE COLUMN `updatedAt` ` actualizado_en` DATETIME(3);

-- Personal_proveedores
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
  CHANGE COLUMN `createdAt` `creado_en` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
  CHANGE COLUMN `updatedAt` `actualizado_en` DATETIME(3);

-- Registros_acceso
ALTER TABLE `registros_acceso`
  CHANGE COLUMN `userName` `nombre_usuario` VARCHAR(255),
  CHANGE COLUMN `userDni` `dni_usuario` VARCHAR(20),
  CHANGE COLUMN `role` `rol` VARCHAR(100),
  CHANGE COLUMN `status` `estado` VARCHAR(50),
  CHANGE COLUMN `action` `accion` VARCHAR(255),
  CHANGE COLUMN `zone` `zona` VARCHAR(100),
  CHANGE COLUMN `type` `tipo` VARCHAR(50),
  CHANGE COLUMN `timestamp` `fecha_hora` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
  CHANGE COLUMN `employeeId` `empleado_id` INT,
  CHANGE COLUMN `transportId` `transporte_id` INT;

-- Pases_temporales
ALTER TABLE `pases_temporales`
  CHANGE COLUMN `fullName` `nombre_completo` VARCHAR(255),
  CHANGE COLUMN `company` `empresa` VARCHAR(255),
  CHANGE COLUMN `reason` `motivo` TEXT,
  CHANGE COLUMN `authorizedBy` `autorizado_por` VARCHAR(255),
  CHANGE COLUMN `issuedById` `emitido_por_id` INT,
  CHANGE COLUMN `validFrom` `valido_desde` DATETIME,
  CHANGE COLUMN `validUntil` `valido_hasta` DATETIME,
  CHANGE COLUMN `status` `estado` VARCHAR(50) DEFAULT 'Activo',
  CHANGE COLUMN `createdAt` `creado_en` DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3);

SELECT 'Columnas renombradas exitosamente' AS resultado;
