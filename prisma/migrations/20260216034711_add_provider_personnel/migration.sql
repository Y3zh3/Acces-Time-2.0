-- CreateTable
CREATE TABLE `provider_personnel` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fullName` VARCHAR(255) NOT NULL,
    `dni` VARCHAR(20) NOT NULL,
    `company` VARCHAR(255) NOT NULL,
    `position` VARCHAR(100) NULL,
    `phone` VARCHAR(50) NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'Activo',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `provider_personnel_dni_key`(`dni`),
    INDEX `provider_personnel_dni_idx`(`dni`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
