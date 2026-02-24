/*
  Warnings:

  - You are about to alter the column `role` on the `employees` table. The data in that column could be lost. The data in that column will be cast from `VarChar(100)` to `Enum(EnumId(0))`.

*/
-- AlterTable
ALTER TABLE `employees` ADD COLUMN `contractExpiry` DATETIME(3) NULL,
    MODIFY `role` ENUM('ADMINISTRADOR', 'SUPERVISOR', 'EMPLEADO', 'SEGURIDAD', 'PROVEEDOR', 'TRANSPORTE', 'RRHH', 'AUDITOR') NOT NULL DEFAULT 'EMPLEADO';

-- AlterTable
ALTER TABLE `temporary_passes` ADD COLUMN `issuedById` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `temporary_passes` ADD CONSTRAINT `temporary_passes_issuedById_fkey` FOREIGN KEY (`issuedById`) REFERENCES `employees`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
