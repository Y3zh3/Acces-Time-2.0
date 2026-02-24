import { promises as fs } from 'fs';
import path from 'path';

/**
 * Guarda una imagen biométrica en el sistema de archivos
 * @param imageDataUri - Imagen en formato data:image/jpeg;base64,...
 * @param dni - DNI del empleado
 * @returns Ruta relativa de la imagen guardada
 */
export async function saveBiometricImage(
  imageDataUri: string,
  dni: string
): Promise<string> {
  // Extraer el base64 del data URI
  const base64Data = imageDataUri.replace(/^data:image\/\w+;base64,/, '');
  const buffer = Buffer.from(base64Data, 'base64');

  // Crear carpeta si no existe
  const uploadDir = path.join(process.cwd(), 'public', 'uploads', 'biometric-photos');
  await fs.mkdir(uploadDir, { recursive: true });

  // Nombre del archivo
  const timestamp = Date.now();
  const fileName = `${dni}_${timestamp}.jpg`;
  const filePath = path.join(uploadDir, fileName);

  // Guardar archivo
  await fs.writeFile(filePath, buffer);

  // Retornar ruta relativa (para acceder desde el navegador)
  return `/uploads/biometric-photos/${fileName}`;
}

/**
 * Elimina una imagen biométrica del sistema de archivos
 * @param photoPath - Ruta relativa de la foto (/uploads/biometric-photos/...)
 */
export async function deleteBiometricImage(photoPath: string): Promise<void> {
  try {
    const fullPath = path.join(process.cwd(), 'public', photoPath);
    await fs.unlink(fullPath);
  } catch (error) {
    console.error('Error eliminando foto:', error);
  }
}
