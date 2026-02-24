-- CreateTable
CREATE TABLE `provider_companies` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `companyName` VARCHAR(255) NOT NULL,
    `ruc` VARCHAR(50) NULL,
    `supplyType` VARCHAR(100) NULL,
    `commercialContact` VARCHAR(255) NULL,
    `phone` VARCHAR(50) NULL,
    `address` VARCHAR(500) NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'Activo',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `provider_companies_companyName_key`(`companyName`),
    INDEX `provider_companies_companyName_idx`(`companyName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
