# Prototipo — App iOS de información electoral y votación

App nativa para iPhone desarrollada en **Swift y SwiftUI** como proyecto académico en ISIL (2025). Permite consultar candidatos y partidos, ver sus propuestas, emitir un voto por usuario, revisar estadísticas y consultar un calendario de eventos electorales.

## Capturas de pantalla

<!-- Agrega aquí 3 o 4 capturas: login, inicio con candidatos, detalle/votación, estadísticas, calendario -->
| Login | Inicio | Detalle y voto | Estadísticas |
|---|---|---|---|
| ![](screenshots/login.png) | ![](screenshots/home.png) | ![](screenshots/detalle.png) | ![](screenshots/estadisticas.png) |

## Funcionalidades

- Registro e inicio de sesión con **Firebase Authentication** (correo y contraseña) y **Google Sign-In**.
- Sesión persistente: al reabrir la app, el usuario entra sin volver a iniciar sesión.
- Lista de candidatos filtrable por partido y pantalla de detalle con profesión, lugar de nacimiento y propuestas.
- Votación de un solo voto por usuario, con confirmación y manejo del caso de voto duplicado (HTTP 409).
- Estadísticas de votos con ordenamiento (más populares / alfabético) y botón de actualizar.
- Calendario de eventos electorales con `DatePicker`.
- Perfil de usuario editable y pantallas informativas (términos, condiciones, nosotros).

## Tecnologías

- Swift, SwiftUI (`TabView`, `NavigationStack`, `AsyncImage`, `DatePicker`)
- Arquitectura **MVVM** con capa de repositorio (`ObservableObject`, `@StateObject`, `@EnvironmentObject`)
- Firebase Authentication, Google Sign-In
- Consumo de API REST con `URLSession`, `async/await` y `Codable`
- Xcode, Git y GitHub

## Estructura del proyecto

```
Prototipo/
├── models/      # Modelos (Candidato, Partido, Evento, UserModel) y repositorio de Firebase
├── ViewModel/   # FirebaseViewModel (estado de autenticación)
├── View/        # Vistas SwiftUI (Home, Detalle, Estadísticas, Calendario, Perfil...)
└── PrototipoApp.swift
```

## Cómo ejecutarlo

1. Clona el repositorio y abre `Prototipo.xcodeproj` en Xcode.
2. Crea un proyecto en [Firebase](https://console.firebase.google.com), registra una app iOS con el *bundle identifier* del proyecto y activa **Authentication** (correo y Google).
3. Descarga tu `GoogleService-Info.plist` y colócalo en la raíz del proyecto (no se sube al repositorio).
4. Selecciona un simulador de iPhone y ejecuta con **Cmd + R**.

> Los datos de candidatos, eventos y votos vienen de una API externa (PHP/JSON); sin ella la app muestra las pantallas pero no carga datos.

## Autora

**Sibel Cabrera** — Estudiante de Desarrollo de Software (ISIL) · [LinkedIn](https://www.linkedin.com/in/sibel-cabrera-07431a342/)
