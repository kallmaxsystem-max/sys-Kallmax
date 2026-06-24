# Tasko - Gestión Moderna de Tareas

Una aplicación de gestión de tareas construida con **Flask + Python** (migrado desde Next.js + React).

## 🚀 Características

- **Dashboard Intuitivo**: Visualiza todas tus tareas y métricas en un solo lugar
- **Gestión de Tareas**: Organiza, filtra y gestiona tus tareas por estado y prioridad
- **Calendario**: Visualiza eventos y fechas límite de forma clara
- **Analytics**: Obtén insights sobre tu productividad y la del equipo
- **Gestión de Equipo**: Colabora con tu equipo, visualiza miembros y su estado
- **Configuración Personalizada**: Ajusta tus preferencias y configuración de seguridad
- **Tema Claro/Oscuro**: Interfaz adaptable según tus preferencias
- **Responsive**: Diseño mobile-first que funciona en todos los dispositivos

## 📋 Requisitos Previos

- Python 3.8 o superior
- pip (gestor de paquetes de Python)

## 🔧 Instalación

### 1. Clonar o descargar el proyecto

```bash
git clone <repository-url>
cd /vercel/share/v0-project
```

### 2. Crear un entorno virtual (opcional pero recomendado)

```bash
python3 -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```

### 3. Instalar dependencias

```bash
pip install -r requirements.txt
```

## ▶️ Ejecutar la Aplicación

```bash
python3 main.py
```

La aplicación estará disponible en: **http://localhost:5000**

## 📁 Estructura del Proyecto

```
/vercel/share/v0-project/
├── app/
│   ├── __init__.py           # Inicialización de Flask
│   ├── routes/               # Rutas de la aplicación
│   │   ├── main.py          # Rutas principales (Dashboard, Logout)
│   │   ├── tasks.py         # Ruta de Tareas
│   │   ├── calendar.py      # Ruta de Calendario
│   │   ├── analytics.py     # Ruta de Analytics
│   │   ├── team.py          # Ruta de Equipo
│   │   ├── settings.py      # Ruta de Configuración
│   │   ├── help.py          # Ruta de Ayuda
│   │   └── __init__.py      # Inicialización de blueprints
│   ├── templates/           # Plantillas Jinja2 HTML
│   │   ├── base.html        # Plantilla base (layout)
│   │   ├── dashboard.html   # Página de Dashboard
│   │   ├── tasks.html       # Página de Tareas
│   │   ├── calendar.html    # Página de Calendario
│   │   ├── analytics.html   # Página de Analytics
│   │   ├── team.html        # Página de Equipo
│   │   ├── settings.html    # Página de Configuración
│   │   ├── help.html        # Página de Ayuda
│   │   └── components/      # Componentes reutilizables
│   │       └── sidebar.html # Sidebar de navegación
│   └── static/              # Archivos estáticos
│       ├── css/             # Estilos CSS
│       ├── js/              # JavaScript del cliente
│       └── images/          # Imágenes y avatares
├── main.py                  # Punto de entrada de la aplicación
├── requirements.txt         # Dependencias de Python
└── README.md               # Este archivo
```

## 🎨 Tecnologías Utilizadas

- **Backend**: Flask 3.0.0
- **Frontend**: HTML5 + Jinja2 Templates
- **Styling**: Tailwind CSS v4 (vía CDN)
- **Icons**: Font Awesome 6.4.0
- **JavaScript**: Vanilla JS para interactividad

## 📖 Páginas Principales

### Dashboard
- Resumen de tareas completadas y activas
- Lista de proyectos recientes con progreso
- Recordatorios y notificaciones
- Información del equipo
- Estadísticas de productividad

### Tareas
- Vista de todas las tareas
- Filtros por estado (Todas, En Progreso, Completadas, Urgentes)
- Indicadores visuales de prioridad y estado
- Información de proyecto y fecha de vencimiento

### Calendario
- Vista del mes actual
- Eventos próximos
- Fechas límite importantes

### Analytics
- Métricas de productividad
- Tasas de finalización por semana
- Distribución de carga por proyecto
- Rendimiento del equipo

### Equipo
- Lista de miembros con avatares
- Estado de conexión (Online/Offline)
- Cargo y información de cada miembro

### Configuración
- Información de cuenta
- Preferencias de notificaciones
- Configuración de seguridad

## 🌓 Tema Claro/Oscuro

El tema se puede cambiar haciendo clic en el ícono de luna/sol en la esquina superior derecha. La preferencia se guarda automáticamente en localStorage.

## 🔗 Rutas Disponibles

| Ruta | Descripción |
|------|-------------|
| `/` | Dashboard principal |
| `/tasks` | Gestor de tareas |
| `/calendar` | Vista de calendario |
| `/analytics` | Panel de analytics |
| `/team` | Gestión del equipo |
| `/settings` | Configuración de usuario |
| `/help` | Centro de ayuda |
| `/logout` | Cerrar sesión (redirige al dashboard) |

## 💾 Datos de Prueba

La aplicación incluye datos de prueba ficticios para demostración:
- 42 tareas totales
- 5 proyectos activos
- 8 miembros del equipo
- Métricas de productividad simuladas

*Nota: En una aplicación real, estos datos vendrían de una base de datos.*

## 🚀 Próximos Pasos

Para expandir esta aplicación, considera:

1. **Base de Datos**: Integrar SQLAlchemy + PostgreSQL/SQLite
2. **Autenticación**: Implementar login/registro con Flask-Login
3. **API REST**: Crear endpoints API para operaciones CRUD
4. **Validación**: Añadir validación de formularios con WTForms
5. **Testing**: Implementar tests unitarios y de integración

## 📝 Notas de la Migración

Esta aplicación fue migrada exitosamente desde:
- **Frontend**: React 19.2 + Next.js 16 → Jinja2 Templates
- **Styling**: Tailwind CSS (build process) → Tailwind CSS (CDN)
- **Componentes**: React Components → HTML Templates
- **Estado**: React Hooks → Server-side rendering

El diseño visual y la funcionalidad se han mantenido prácticamente idénticos durante la migración.

## 📄 Licencia

Este proyecto es de código abierto. Siéntete libre de usarlo y modificarlo.

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor, abre un issue o envía un pull request con tus cambios.

---

¿Preguntas o problemas? Consulta la página de Ayuda en la aplicación o abre un issue en el repositorio.
