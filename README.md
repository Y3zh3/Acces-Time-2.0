# 🏭 AccessTime - Sistema de Control de Acceso

Sistema empresarial de control de acceso para plantas de electrodomésticos con **autenticación biométrica** usando IA.

## 🚀 Inicio Rápido

### 1. Instalar dependencias

```bash
npm install
```

### 2A. Reconocimiento Facial Real (Recomendado)

Para usar reconocimiento facial con base de datos real:

```bash
# Descargar modelos de ML (~6 MB)
npm run download-models
```

Luego registra empleados en `/face-registration` y activa el toggle "Reconocimiento Real" en `/validation`.

**✅ Ventajas**: Funciona offline, más rápido, 100% privado, sin costos de API.

### 2B. IA Generativa (Alternativo)

Para usar IA generativa de Google Gemini:

1. Obtén una API key gratuita: [https://aistudio.google.com/apikey](https://aistudio.google.com/apikey)
2. Crea `.env.local`:

```env
GOOGLE_GENAI_API_KEY=tu_api_key_aqui
```

**⚠️ Notas**: Requiere internet, consume cuota de API, simula reconocimiento.

### 3. Ejecutar el proyecto

```bash
npm run dev
```

Abre [http://localhost:3000](http://localhost:3000) en tu navegador.

## 📖 Documentación Completa

- **[Base de Datos de Rostros Reales](docs/FACE_DATABASE_REAL.md)** - Reconocimiento facial 100% funcional
- **[Guía de Biometría IA](docs/BIOMETRIA_SETUP.md)** - Configuración con Google Gemini
- **[Blueprint](docs/blueprint.md)** - Especificaciones del proyecto

## 🎯 Funcionalidades

- ✅ **Reconocimiento Facial Real** - face-api.js con descriptores de 128D (NUEVO)
- ✅ **Registro Biométrico** - Captura y almacenamiento de rostros en Firebase
- ✅ **Validación Biométrica IA** - Gemini Vision como alternativa
- ✅ **Validación por DNI** - Búsqueda en base de datos Firestore
- ✅ **Gestión de Credenciales** - Personal, proveedores, transportistas
- ✅ **Pases Temporales** - Para trabajadores de tiempo limitado
- ✅ **Registro de Accesos** - Logs en tiempo real con auditoría
- ✅ **Reportes y Analítica** - Dashboard con métricas

## 🔑 Acceso Demo

Ir a `/login` y usar:

- **Usuario**: Administrador
- **Contraseña**: `admin123`

## 🛠️ Stack Tecnológico

Reconocimiento Facial\*\*: face-api.js (TensorFlow.js)

- **IA Alternativa**: Google Gemini 1.5 Flash (Genkit)
- **Backend**: Firebase (Firestore + Auth + StorageypeScript
- **UI**: Tailwind CSS + shadcn/ui
- **IA**: Google Gemini 1.5 Flash (Genkit)
- **Backend**: Firebase (Firestore + Auth)
- **Despliegue**: Firebase Hosting

## 📂 Estructura del Proyecto

```
src/
├── ai/
│   ├── flows/
│   │   └── biometric-verify-flow.ts  # Flujo de verificación con IA
│   └── genkit.ts                      # Configuración de Gemini AI
├── app/
│   ├── login/                         # Autenticación por roles
│   ├── validation/                    # Terminal de validación (ambos métodos)
│   ├── face-registration/             # Registro de rostros reales (NUEVO)
│   ├── credentials/                   # Gestión de credenciales
│   └── logs/                          # Registro de accesos
├── components/                        # Componentes UI reutilizables
├── lib/
│   ├── face-recognition.ts            # Lógica de face-api.js (NUEVO)
│   └── face-verification-real.ts      # Verificación con BD real (NUEVO)
└── firebase/                          # Configuración de Firebase
```

## 🧪 Desarrollo

### Descargar modelos de reconocimiento facial (primera vez)

```bash
npm run download-models
```

### Ejecutar en modo desarrollo

```bash
npm run dev
```

### Ejecutar Genkit UI (para probar flujos de IA)

```bash
npm run genkit:dev
```

### Build para producción

```bash
npm run build
npm start
```

## 📝 Notas Importantes

- La cámara web requiere HTTPS o localhost para funcionar
- **Reconocimiento Real**: Funciona 100% offline una vez descargados los modelos
- **IA Generativa**: Requiere API key y tiene cuota limitada ([ver límites](https://ai.google.dev/pricing))
- Para producción, usa el reconocimiento real con Firebase Storage para las fotos
