# 🚀 Configuración de SECRET_KEY en Railway

## ✅ Ya generaste tu SECRET_KEY

Acabas de ejecutar `generar_secret_key.py` y obtuviste dos opciones de claves. 

**Ejemplo de lo que viste:**
```
Opción 1 - Hexadecimal (64 caracteres):
SECRET_KEY=3f91415173c937542125084cdc7cce3d245818bf70c95a3f8f7458b661fdf218

Opción 2 - URL-safe (más compacta):
SECRET_KEY=K9JAh5DwyLNv_hQkF0QTbJIv4SOTMtpWynvmAQaL1_0
```

> ⚠️ **IMPORTANTE:** Las claves mostradas arriba son solo ejemplos. Usa la que TÚ generaste con el script.

---

## 📋 Pasos para configurar en Railway

### 1. Abre tu proyecto en Railway

Ve a: https://railway.app/dashboard

### 2. Selecciona tu proyecto Kallmax

Click en el proyecto donde desplegaste la aplicación.

### 3. Ve a la pestaña "Variables"

En el menú lateral o superior, busca:
```
Variables (o Variables de entorno / Environment Variables)
```

### 4. Añade la nueva variable

- Click en el botón **"+ New Variable"** o **"Add Variable"**
- **Name:** `SECRET_KEY`
- **Value:** Pega una de las claves que generaste (sin el `SECRET_KEY=`)

**Ejemplo:**
```
Name:  SECRET_KEY
Value: 3f91415173c937542125084cdc7cce3d245818bf70c95a3f8f7458b661fdf218
```

### 5. Guarda y redespliega

- Click en **"Add"** o **"Save"**
- Railway automáticamente redesplegará tu aplicación
- Espera 1-2 minutos

### 6. Verifica que funcione

- Abre la URL de tu app en Railway
- Deberías ver tu aplicación funcionando
- El error "Not Found" debería desaparecer

---

## 🔧 Otras variables que podrías necesitar

Si tu aplicación usa base de datos MySQL u otros servicios:

```
DB_HOST=tu-host-mysql
DB_PORT=3306
DB_USER=tu-usuario
DB_PASSWORD=tu-password
DB_NAME=kallmax_db
```

---

## 🧪 Para desarrollo local

### Opción 1: Crear archivo .env

1. Copia `.env.example` como `.env`:
   ```cmd
   copy .env.example .env
   ```

2. Edita `.env` y añade tu SECRET_KEY:
   ```
   SECRET_KEY=tu-clave-aqui
   DEBUG=True
   ```

3. Instala python-dotenv si no lo tienes:
   ```cmd
   pip install python-dotenv
   ```

### Opción 2: Variable temporal en CMD

```cmd
set SECRET_KEY=tu-clave-aqui
set PORT=5000
python main.py
```

---

## 🔐 Seguridad

### ✅ HACER:
- Genera una clave diferente para cada entorno (local, staging, producción)
- Mantén las claves en Railway/Variables de entorno
- Usa `.env` para desarrollo local (ya está en .gitignore)

### ❌ NO HACER:
- NO subas las claves a Git
- NO compartas las claves públicamente
- NO uses la misma clave en producción y desarrollo

---

## 🆘 Troubleshooting

### "Application failed to respond"
1. Verifica que SECRET_KEY esté en las variables de Railway
2. Revisa los logs: Click en "Deployments" > último deploy > "View Logs"
3. Busca errores relacionados con la SECRET_KEY

### "Error 500"
- Verifica que la clave no tenga espacios al inicio o final
- Asegúrate de haber copiado la clave completa

### Regenerar clave
Si necesitas una nueva clave:
```cmd
python generar_secret_key.py
```

---

## 📚 Recursos

- [Railway Docs](https://docs.railway.app/)
- [Flask Security](https://flask.palletsprojects.com/en/3.0.x/config/#SECRET_KEY)
- [Python Secrets Module](https://docs.python.org/3/library/secrets.html)

---

## ✨ Siguiente paso

Una vez configurada la SECRET_KEY, tu aplicación debería funcionar correctamente en Railway. 

Si aún hay problemas:
1. Revisa los logs de Railway
2. Verifica que todas las rutas funcionen
3. Prueba acceder a: `https://tu-app.up.railway.app`
