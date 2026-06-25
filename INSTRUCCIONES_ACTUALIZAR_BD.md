# 📋 INSTRUCCIONES PARA ACTUALIZAR BASE DE DATOS

## ✅ CAMBIOS REALIZADOS

Se ha migrado la base de datos de **209.74.89.191** a **Namecheap (localhost)**.

### Archivos modificados:
- ✅ `app/config.py` - Configuración centralizada de BD usando variables de entorno
- ✅ `app/routes/auth.py` - Usa DatabaseConfig
- ✅ `app/funciones/register_user.py` - Usa DatabaseConfig
- ✅ `.env` - Variables de entorno para LOCAL
- ✅ `namecheap_deploy/.env` - Variables de entorno para PRODUCCIÓN
- ✅ `namecheap_deploy/app/config.py` - Config para producción
- ✅ `namecheap_deploy/app/routes/auth.py` - Actualizado
- ✅ `namecheap_deploy/app/funciones/register_user.py` - Actualizado

---

## 🔧 CONFIGURACIÓN LOCAL

### 1. Editar `.env` en la raíz del proyecto

```env
# Database Configuration - NAMECHEAP MYSQL
DB_HOST=localhost
DB_PORT=3306
DB_USER=kallgwkn_user
DB_PASSWORD=TU_PASSWORD_AQUI  ← Cambia esto por el password real
DB_NAME=kallgwkn_kallmax_bd
```

### 2. Probar en local (si tienes acceso a la BD de Namecheap)

```bash
python main.py
```

Si no tienes acceso remoto a MySQL de Namecheap, solo podrás probar en producción.

---

## 🚀 ACTUALIZAR PRODUCCIÓN (NAMECHEAP)

### Paso 1: Subir archivos con WinSCP

Conectarse con WinSCP:
- **Host:** 162.213.251.186
- **Usuario:** kallgwkn
- **Password:** #215292159xD

Subir estos archivos a `/home/kallgwkn/kallmax_app/`:

1. **`namecheap_deploy/app/config.py`** → `/home/kallgwkn/kallmax_app/app/config.py`
2. **`namecheap_deploy/app/routes/auth.py`** → `/home/kallgwkn/kallmax_app/app/routes/auth.py`
3. **`namecheap_deploy/app/funciones/register_user.py`** → `/home/kallgwkn/kallmax_app/app/funciones/register_user.py`

### Paso 2: Editar archivo .env en producción

En WinSCP, abre el archivo `/home/kallgwkn/kallmax_app/.env` y actualiza:

```env
# Flask Configuration
SECRET_KEY=7c705c25adc799bf3444babc43da4bb48fe11dfee5dd826a242ad7f5b71533cd
DEBUG=False

# Database Configuration - NAMECHEAP MYSQL
DB_HOST=localhost
DB_PORT=3306
DB_USER=kallgwkn_user
DB_PASSWORD=TU_PASSWORD_REAL_AQUI  ← Coloca el password del usuario MySQL
DB_NAME=kallgwkn_kallmax_bd
```

### Paso 3: Reiniciar aplicación

**Opción A: Desde cPanel**
1. Ve a **Setup Python App**
2. Encuentra tu aplicación `kallmax_app`
3. Haz clic en **Restart**

**Opción B: Crear archivo restart.txt (SSH)**
```bash
touch ~/kallmax_app/tmp/restart.txt
```

**Opción C: Modificar passenger_wsgi.py**
Edita cualquier línea del archivo y guárdalo (esto fuerza restart automático)

### Paso 4: Verificar en el navegador

1. Abre: https://kallmaxcorredores.com
2. Intenta hacer login
3. Verifica que funcione correctamente

---

## 📊 CREDENCIALES DE BASE DE DATOS

### Base de datos Namecheap:
- **Host:** localhost (desde el servidor)
- **Puerto:** 3306
- **Usuario:** kallgwkn_user
- **Base de datos:** kallgwkn_kallmax_bd
- **Password:** [Obtener desde cPanel > MySQL Databases]

### Cómo obtener/cambiar el password:
1. Ir a cPanel
2. **MySQL Databases**
3. Sección **Current Users**
4. Encontrar usuario `kallgwkn_user`
5. Clic en **Change Password**
6. Copiar el password y pegarlo en el archivo `.env`

---

## 🧪 VERIFICACIÓN

### Verificar conexión a BD:
```python
from app.config import DatabaseConfig
import mysql.connector

try:
    conn = mysql.connector.connect(**DatabaseConfig.get_connection_params())
    print("✅ Conexión exitosa!")
    conn.close()
except Exception as e:
    print(f"❌ Error: {e}")
```

### Logs de la aplicación:
- Ubicación: `/home/kallgwkn/kallmax_app/logs/kallmax.log`
- Ver últimas líneas:
  ```bash
  tail -f ~/kallmax_app/logs/kallmax.log
  ```

---

## ⚠️ NOTAS IMPORTANTES

1. **NO subir .env a Git** - Ya está en .gitignore
2. **Backup de BD** - Ya existe en `kallmax_backup.sql`
3. **Los archivos en `namecheap_deploy/`** son los que van a producción
4. **Los archivos en raíz `app/`** son para desarrollo local

---

## 🔄 ARCHIVOS QUE TIENEN CONEXIÓN A BD

Si necesitas agregar más funcionalidades, estos archivos usan `get_db_connection()`:
- `app/routes/auth.py`
- `app/routes/main.py` (verificar si tiene conexiones)
- `app/funciones/register_user.py`

Todos deben usar:
```python
from app.config import DatabaseConfig

def get_db_connection():
    return mysql.connector.connect(**DatabaseConfig.get_connection_params())
```
