# Guía de Despliegue en Railway - Kallmax

## Cambios realizados para Railway

Se han realizado las siguientes modificaciones para asegurar la compatibilidad con Railway:

### 1. Archivos actualizados:
- ✅ `main.py` - Configurado para detectar entorno Railway
- ✅ `runtime.txt` - Actualizado a Python 3.11.0
- ✅ `app/__init__.py` - SECRET_KEY desde variable de entorno
- ✅ `Procfile` - Configuración de gunicorn

### 2. Archivos nuevos:
- ✅ `.railwayignore` - Ignora archivos no necesarios
- ✅ `nixpacks.toml` - Configuración de build para Railway

## Pasos para desplegar en Railway

### 1. Configurar Variables de Entorno en Railway

En el dashboard de Railway, ve a tu proyecto y añade estas variables:

```
SECRET_KEY=tu-clave-secreta-muy-segura-aqui
PORT=8000
```

**IMPORTANTE:** Genera una SECRET_KEY segura. Puedes usar:
```python
import secrets
print(secrets.token_hex(32))
```

### 2. Si usas Base de Datos MySQL

Añade también estas variables (ajusta según tu configuración):

```
DB_HOST=tu-host-mysql
DB_PORT=3306
DB_USER=tu-usuario
DB_PASSWORD=tu-password
DB_NAME=kallmax_db
```

Y actualiza tu código para usar estas variables.

### 3. Desplegar desde GitHub

1. Conecta tu repositorio de GitHub a Railway
2. Railway detectará automáticamente el proyecto Python
3. Usará `nixpacks.toml` para la configuración de build
4. Iniciará con `gunicorn main:app`

### 4. Desplegar desde Railway CLI

```bash
# Instalar Railway CLI
npm i -g @railway/cli

# Login
railway login

# Inicializar proyecto
railway init

# Desplegar
railway up
```

## Verificación

Después del despliegue:

1. Verifica los logs en Railway Dashboard
2. Accede a la URL proporcionada por Railway
3. Verifica que todas las rutas funcionen correctamente

## Troubleshooting

### Error "Application failed to respond"
- Verifica que el PORT esté configurado correctamente
- Revisa los logs: `railway logs`
- Asegúrate que gunicorn esté en requirements.txt

### Error de importación
- Verifica que la estructura de carpetas sea correcta
- Asegúrate que `app/__init__.py` existe

### Error 500
- Revisa los logs detallados
- Verifica que SECRET_KEY esté configurada
- Verifica conexiones a base de datos si aplica

## Comandos útiles

```bash
# Ver logs en tiempo real
railway logs

# Ver variables de entorno
railway variables

# Abrir dashboard
railway open

# Conectar shell al contenedor
railway shell
```

## Notas importantes

- Railway asigna automáticamente el PORT, no lo establezcas manualmente
- Los archivos estáticos se sirven desde Flask en producción
- Considera usar Railway's PostgreSQL o MySQL si necesitas base de datos
- El dominio será algo como: `tu-app.up.railway.app`

## Estructura de archivos clave

```
sys-Kallmax/
├── main.py              # Punto de entrada principal
├── app/
│   ├── __init__.py      # Factory de la aplicación
│   ├── routes/          # Blueprints
│   ├── templates/       # Templates HTML
│   └── static/          # CSS, JS, imágenes
├── requirements.txt     # Dependencias Python
├── Procfile            # Comando de inicio
├── runtime.txt         # Versión de Python
├── nixpacks.toml       # Configuración de build
└── .railwayignore      # Archivos a ignorar
```

## Soporte

Para más información: https://docs.railway.app/
