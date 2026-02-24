-- CreateTable
CREATE TABLE `employees` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fullName` VARCHAR(255) NOT NULL,
    `dni` VARCHAR(20) NOT NULL,
    `role` VARCHAR(100) NOT NULL,
    `department` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NULL,
    `photoPath` VARCHAR(500) NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'Activo',
    `hasBiometric` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `employees_dni_key`(`dni`),
    INDEX `employees_dni_idx`(`dni`),
    INDEX `employees_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `face_biometrics` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `employeeId` INTEGER NOT NULL,
    `descriptor` TEXT NOT NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `face_biometrics_employeeId_key`(`employeeId`),
    INDEX `face_biometrics_isActive_idx`(`isActive`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transport_personnel` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fullName` VARCHAR(255) NOT NULL,
    `dni` VARCHAR(20) NOT NULL,
    `company` VARCHAR(255) NOT NULL,
    `vehicle` VARCHAR(100) NULL,
    `licensePlate` VARCHAR(20) NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'Activo',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `transport_personnel_dni_key`(`dni`),
    INDEX `transport_personnel_dni_idx`(`dni`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `access_logs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userName` VARCHAR(255) NOT NULL,
    `userDni` VARCHAR(20) NULL,
    `role` VARCHAR(100) NOT NULL,
    `status` VARCHAR(50) NOT NULL,
    `action` VARCHAR(255) NOT NULL,
    `zone` VARCHAR(100) NOT NULL,
    `type` VARCHAR(50) NOT NULL,
    `timestamp` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `employeeId` INTEGER NULL,
    `transportId` INTEGER NULL,

    INDEX `access_logs_timestamp_idx`(`timestamp`),
    INDEX `access_logs_status_idx`(`status`),
    INDEX `access_logs_type_idx`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `temporary_passes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fullName` VARCHAR(255) NOT NULL,
    `dni` VARCHAR(20) NOT NULL,
    `company` VARCHAR(255) NULL,
    `reason` TEXT NOT NULL,
    `authorizedBy` VARCHAR(255) NOT NULL,
    `validFrom` DATETIME(3) NOT NULL,
    `validUntil` DATETIME(3) NOT NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'Activo',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `temporary_passes_validFrom_validUntil_idx`(`validFrom`, `validUntil`),
    INDEX `temporary_passes_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `face_biometrics` ADD CONSTRAINT `face_biometrics_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `employees`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `access_logs` ADD CONSTRAINT `access_logs_employeeId_fkey` FOREIGN KEY (`employeeId`) REFERENCES `employees`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `access_logs` ADD CONSTRAINT `access_logs_transportId_fkey` FOREIGN KEY (`transportId`) REFERENCES `transport_personnel`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
