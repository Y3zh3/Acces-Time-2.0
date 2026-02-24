import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { writeFile, mkdir, unlink } from 'fs/promises';
import path from 'path';
import fs from 'fs';

/**
 * Eliminar foto del sistema de archivos
 */
async function deletePhoto(photoPath: string): Promise<void> {
  try {
    if (!photoPath) return;
    const fullPath = path.join(process.cwd(), 'public', photoPath);
    if (fs.existsSync(fullPath)) {
      await unlink(fullPath);
      console.log('🗑️ Foto antigua eliminada:', photoPath);
    }
  } catch (error) {
    console.error('Error eliminando foto:', error);
  }
}

/**
 * Guardar foto base64 en el sistema de archivos
 */
async function savePhoto(base64Data: string, dni: string): Promise<string> {
  try {
    // Extraer el tipo de imagen y los datos
    const matches = base64Data.match(/^data:image\/(\w+);base64,(.+)$/);
    if (!matches) {
      throw new Error('Formato de imagen inválido');
    }

    const imageType = matches[1];
    const imageData = matches[2];
    const buffer = Buffer.from(imageData, 'base64');

    // Crear directorio si no existe
    const uploadDir = path.join(process.cwd(), 'public', 'uploads', 'transport');
    await mkdir(uploadDir, { recursive: true });

    // Nombre del archivo
    const filename = `${dni}_${Date.now()}.${imageType}`;
    const filepath = path.join(uploadDir, filename);

    // Guardar archivo
    await writeFile(filepath, buffer);

    // Retornar la ruta relativa
    return `/uploads/transport/${filename}`;
  } catch (error) {
    console.error('Error guardando foto:', error);
    throw error;
  }
}

/**
 * GET - Obtener todo el personal de transporte
 */
export async function GET(request: NextRequest) {
  try {
    const transport = await prisma.transportPersonnel.findMany({
      orderBy: { createdAt: 'desc' },
    });

    return NextResponse.json({ transport });
  } catch (error: any) {
    console.error('Error obteniendo personal de transporte:', error);
    return NextResponse.json(
      { error: 'Error al obtener personal de transporte' },
      { status: 500 }
    );
  }
}

/**
 * POST - Registrar nuevo personal de transporte
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { fullName, dni, company, vehicle, licensePlate, photoBase64, descriptor, entryDateTime, exitDateTime } = body;

    // Validaciones
    if (!fullName || !dni || !company) {
      return NextResponse.json(
        { error: 'Faltan campos requeridos (fullName, dni, company)' },
        { status: 400 }
      );
    }

    // Verificar si ya existe el DNI
    const existing = await prisma.transportPersonnel.findUnique({
      where: { dni },
    });

    if (existing) {
      return NextResponse.json(
        { error: 'Ya existe personal con ese DNI' },
        { status: 400 }
      );
    }

    // Guardar foto si se proporcionó
    let photoPath = null;
    if (photoBase64) {
      try {
        photoPath = await savePhoto(photoBase64, dni);
      } catch (error) {
        console.error('Error guardando foto:', error);
        // Continuar sin foto
      }
    }

    // Crear registro con transacción para incluir biométrico
    const newTransport = await prisma.$transaction(async (tx) => {
      // Crear registro de transporte
      const transport = await tx.transportPersonnel.create({
        data: {
          fullName,
          dni,
          company,
          vehicle: vehicle || null,
          licensePlate: licensePlate || null,
          photoPath,
          entryDateTime: entryDateTime ? new Date(entryDateTime) : null,
          exitDateTime: exitDateTime ? new Date(exitDateTime) : null,
          status: 'Activo',
        },
      });

      // Si hay descriptor, crear registro biométrico
      if (descriptor && Array.isArray(descriptor)) {
        await tx.faceBiometric.create({
          data: {
            transportPersonnelId: transport.id,
            descriptor: JSON.stringify(descriptor),
          },
        });
        console.log(`✅ Registro biométrico creado para ${fullName} (Transporte)`);
      }

      return transport;
    });

    return NextResponse.json({ success: true, transport: newTransport });
  } catch (error: any) {
    console.error('Error registrando personal de transporte:', error);
    return NextResponse.json(
      { error: 'Error al registrar personal de transporte' },
      { status: 500 }
    );
  }
}

/**
 * DELETE - Eliminar personal de transporte
 */
export async function DELETE(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');

    if (!id) {
      return NextResponse.json(
        { error: 'ID requerido' },
        { status: 400 }
      );
    }

    // Eliminar (logs se mantienen por SetNull)
    await prisma.transportPersonnel.delete({
      where: { id: parseInt(id) },
    });

    return NextResponse.json({ success: true });
  } catch (error: any) {
    console.error('Error eliminando personal de transporte:', error);
    return NextResponse.json(
      { error: 'Error al eliminar personal de transporte' },
      { status: 500 }
    );
  }
}

/**
 * PUT - Actualizar personal de transporte
 */
export async function PUT(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');
    const body = await request.json();
    const { fullName, dni, company, vehicle, licensePlate, photoPath, entryDateTime, exitDateTime } = body;

    if (!id) {
      return NextResponse.json(
        { error: 'ID requerido' },
        { status: 400 }
      );
    }

    // Si hay nueva foto (base64), guardarla primero y eliminar la antigua
    let newPhotoPath = undefined;
    if (photoPath && photoPath.startsWith('data:image')) {
      try {
        // Obtener registro actual para eliminar foto antigua
        const current = await prisma.transportPersonnel.findUnique({
          where: { id: parseInt(id) },
          select: { photoPath: true }
        });

        // Eliminar foto antigua si existe
        if (current?.photoPath) {
          await deletePhoto(current.photoPath);
        }

        // Guardar nueva foto
        newPhotoPath = await savePhoto(photoPath, dni || 'temp');
        console.log('✅ Nueva foto guardada:', newPhotoPath);
      } catch (error) {
        console.error('Error guardando nueva foto:', error);
        // Continuar sin actualizar la foto
      }
    }

    const updated = await prisma.transportPersonnel.update({
      where: { id: parseInt(id) },
      data: {
        fullName: fullName || undefined,
        dni: dni || undefined,
        company: company || undefined,
        vehicle: vehicle || undefined,
        licensePlate: licensePlate || undefined,
        photoPath: newPhotoPath || undefined,
        entryDateTime: entryDateTime ? new Date(entryDateTime) : undefined,
        exitDateTime: exitDateTime ? new Date(exitDateTime) : undefined,
      },
    });

    return NextResponse.json({ success: true, transport: updated });
  } catch (error: any) {
    console.error('Error actualizando personal de transporte:', error);
    return NextResponse.json(
      { error: 'Error al actualizar personal de transporte' },
      { status: 500 }
    );
  }
}

/**
 * PATCH - Actualizar estado del personal de transporte
 */
export async function PATCH(request: NextRequest) {
  try {
    const body = await request.json();
    const { id, status } = body;

    if (!id || !status) {
      return NextResponse.json(
        { error: 'ID y status requeridos' },
        { status: 400 }
      );
    }

    const updated = await prisma.transportPersonnel.update({
      where: { id: parseInt(id) },
      data: { status },
    });

    return NextResponse.json({ success: true, transport: updated });
  } catch (error: any) {
    console.error('Error actualizando personal de transporte:', error);
    return NextResponse.json(
      { error: 'Error al actualizar personal de transporte' },
      { status: 500 }
    );
  }
}
