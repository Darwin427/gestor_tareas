# gestor_tareas

App Flutter para gestionar tareas, notas y calificaciones académicas con Firebase
(Authentication + Cloud Firestore).

## Stack

- Flutter `^3.11.4` · Dart `3.11.4`
- `firebase_core ^3.0.0`, `firebase_auth ^5.0.0`, `cloud_firestore ^5.0.0`
- `table_calendar ^3.1.2`, `intl ^0.19.0`
- Material Design 3, tema claro/oscuro automático según el sistema

## Estructura del código

```
lib/
├── firebase_options.dart   # generado por flutterfire (no editar)
├── main.dart               # entry point + init Firebase + i18n es
├── theme/
│   └── app_theme.dart      # colores, paleta, íconos, ThemeData light/dark
├── models/
│   ├── subject.dart
│   ├── task_item.dart
│   ├── note.dart
│   └── grade_item.dart
├── services/
│   ├── auth_service.dart      # FirebaseAuth wrapper (login/register/signOut)
│   └── firestore_service.dart # CRUD por colección bajo users/{uid}/...
├── widgets/                # PriorityBadge, EmptyState, ImportanciaSelector...
└── screens/
    ├── auth/               # AuthGate, LoginScreen, RegisterScreen
    ├── main_screen.dart    # BottomNav 3 tabs + FAB expandible
    ├── tasks/              # Tab 0
    ├── calendar/           # Tab 1
    ├── grades/             # Tab 2 + DetalleMateriaScreen (3 sub-tabs)
    └── forms/              # CrearTarea, CrearNota, CrearGradeItem, CrearMateria
```

## Estructura en Firestore

Todos los documentos viven bajo `users/{uid}/...`:

| Colección | Campos |
|---|---|
| `subjects/{id}` | `nombre: string`, `color: string (#hex)`, `iconName: string`, `creadoEn: Timestamp` |
| `tasks/{id}` | `titulo`, `descripcion`, `subjectId`, `importancia ('Alta'\|'Media'\|'Baja')`, `fechaLimite: Timestamp`, `creadoEn: Timestamp` |
| `notes/{id}` | `titulo`, `contenido`, `subjectId`, `importancia`, `taskId?` (opcional), `creadoEn: Timestamp` |
| `gradeItems/{id}` | `subjectId`, `nombre`, `porcentaje: number`, `nota: number?` (null si aún no se evalúa), `creadoEn: Timestamp` |

## Reglas de seguridad de Firestore

Asegúrate de tener publicadas estas reglas (Firebase Console → Firestore → Rules):

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
    }
  }
}
```

## Cómo correr el proyecto

### Primera vez (después de clonar)

```powershell
flutter pub get
```

### En navegador (Chrome)

```powershell
flutter run -d chrome
```

### En Android (con dispositivo USB conectado o emulador corriendo)

```powershell
flutter devices    # lista dispositivos disponibles
flutter run        # o: flutter run -d <device-id>
```

### Compilación release

```powershell
flutter build apk        # Android
flutter build web        # Web (genera build/web/)
```

## Setup de Firebase (ya hecho)

Este proyecto ya tiene `firebase_options.dart` generado vía
`flutterfire configure` apuntando al proyecto `gestor-tareas-1f581`.

Si necesitas re-configurarlo (por ejemplo para otro proyecto Firebase):

```powershell
flutter pub global activate flutterfire_cli   # solo si no está instalado
flutterfire configure                          # interactivo
```

### Authentication

Asegúrate de tener habilitado **Email/Password** en Firebase Console →
Authentication → Sign-in method.

## Convenciones del código

- **StreamBuilder** en todas las listas que leen Firestore — actualización en
  tiempo real.
- **TextEditingController** + `GlobalKey<FormState>` en todos los formularios.
- Colores de prioridad **constantes** en toda la app:
  - Alta = `#E24B4A` (rojo)
  - Media = `#BA7517` (ámbar)
  - Baja = `#3B6D11` (verde)
- Color de acento principal: `#534AB7` (morado).
- Material Design 3, ColorScheme generado desde el seed morado.

## Limitaciones conocidas / próxima versión

- Adjuntos en notas no implementados (subir archivos a Storage).
- No hay edición ni borrado de tareas/notas/items (solo creación y lectura).
  Para borrar a mano: Firebase Console → Firestore → documento → menú "..." → Delete.
- No hay notificaciones push de fechas límite.
