# 🌐 Configurar Dominio de Namecheap con Railway

## Opción 1: Apuntar Dominio de Namecheap a Railway (RECOMENDADO)

Esta es la opción más simple y moderna. Tu app sigue en Railway pero usa tu dominio personalizado.

### Ventajas:
- ✅ Railway ya está funcionando
- ✅ No necesitas mover archivos
- ✅ Actualizaciones automáticas desde Git
- ✅ Escalabilidad automática
- ✅ SSL/HTTPS gratis
- ✅ Más rápido y moderno

---

## 📋 Pasos para conectar tu dominio:

### PASO 1: Obtener configuración DNS de Railway

#### 1.1 En Railway Dashboard:
1. Ve a tu proyecto Kallmax
2. Click en **"Settings"** o **"Domains"**
3. Click en **"+ Custom Domain"** o **"Add Domain"**
4. Escribe tu dominio (ejemplo: `kallmax.com` o `www.kallmax.com`)
5. Railway te mostrará los registros DNS que necesitas configurar

Railway te dará algo como:
```
Type: CNAME
Name: www (o @)
Value: sys-kallmax-production-xxxx.up.railway.app
```

O tal vez:
```
Type: A
Name: @
Value: 123.45.67.89
```

**IMPORTANTE:** Anota estos valores, los necesitarás en el siguiente paso.

---

### PASO 2: Configurar DNS en Namecheap

#### 2.1 Inicia sesión en Namecheap:
1. Ve a: https://www.namecheap.com/
2. Inicia sesión
3. Ve a **"Domain List"**
4. Click en **"Manage"** junto a tu dominio

#### 2.2 Accede a DNS Settings:
1. En la página de gestión del dominio
2. Click en la pestaña **"Advanced DNS"**

#### 2.3 Configurar registros DNS:

##### Si Railway te dio un CNAME:

1. **Eliminar registros existentes** (si hay):
   - Busca registros con Type "A Record" o "CNAME Record" para "@" o "www"
   - Click en el icono de basura para eliminarlos

2. **Añadir nuevo registro CNAME:**
   - Click en **"Add New Record"**
   - **Type:** CNAME Record
   - **Host:** www
   - **Value:** sys-kallmax-production-xxxx.up.railway.app (el que te dio Railway)
   - **TTL:** Automatic

3. **Añadir registro para dominio raíz (opcional):**
   - Click en **"Add New Record"**
   - **Type:** URL Redirect Record
   - **Host:** @
   - **Value:** http://www.tudominio.com
   - **Redirect Type:** Permanent (301)

##### Si Railway te dio registros A:

1. **Añadir registro A:**
   - Click en **"Add New Record"**
   - **Type:** A Record
   - **Host:** @
   - **Value:** [IP que te dio Railway]
   - **TTL:** Automatic

2. **Añadir registro A para www:**
   - Click en **"Add New Record"**
   - **Type:** A Record
   - **Host:** www
   - **Value:** [misma IP]
   - **TTL:** Automatic

#### 2.4 Guardar cambios:
- Click en **"Save All Changes"** (botón verde)

---

### PASO 3: Esperar propagación DNS

- Los cambios DNS tardan entre **5 minutos a 48 horas**
- Normalmente: **15-30 minutos**
- Puedes verificar con: https://dnschecker.org/

---

### PASO 4: Verificar en Railway

1. Regresa a Railway Dashboard
2. Ve a **"Domains"**
3. Deberías ver tu dominio con estado **"Active"** o **"Verifying..."**
4. Espera a que cambie a **"Active"**

---

### PASO 5: Probar tu dominio

1. Abre tu navegador
2. Ve a: `https://www.tudominio.com`
3. ¡Deberías ver tu aplicación Kallmax! 🎉

Railway automáticamente generará certificado SSL (HTTPS).

---

## Opción 2: Desplegar directamente en Namecheap

Si prefieres usar el hosting de Namecheap (el que ya tienes configurado con passenger_wsgi.py):

### Ventajas:
- Ya tienes el servidor configurado
- Archivos ya adaptados (passenger_wsgi.py, app.py)

### Desventajas:
- Más lento que Railway
- Actualizaciones manuales
- Sin integración con Git
- Configuración más compleja

---

## 📋 Pasos para desplegar en Namecheap:

### PASO 1: Acceder a tu hosting de Namecheap

#### 1.1 Acceso por cPanel:
1. Inicia sesión en Namecheap
2. Ve a **"Hosting List"**
3. Click en **"cPanel"** o **"Manage"**

#### 1.2 O acceso por SSH (si lo tienes habilitado):
```bash
ssh usuario@tudominio.com
```

---

### PASO 2: Preparar archivos para Namecheap

Los archivos que YA tienes configurados para Namecheap son:
- ✅ `passenger_wsgi.py`
- ✅ `app.py`

Pero necesitamos hacer algunos ajustes:

#### 2.1 Verificar passenger_wsgi.py:

Tu archivo actual debería verse así:
```python
#!/usr/bin/env python3
import sys
import os

# Configuración del intérprete para Namecheap
INTERP = os.path.join(os.environ.get('HOME', '/home/kallgwkn'), 'virtualenv', 'kallmax_app', '3.9', 'bin', 'python3')

if sys.executable != INTERP:
    os.execl(INTERP, INTERP, *sys.argv)

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from main import app as application

application.config['DEBUG'] = False
```

**IMPORTANTE:** Ajusta `/home/kallgwkn` a tu usuario real de Namecheap.

---

### PASO 3: Subir archivos a Namecheap

#### Opción A - Usando File Manager de cPanel:

1. En cPanel, abre **"File Manager"**
2. Navega a `public_html` o la carpeta de tu dominio
3. Click en **"Upload"**
4. Sube todos los archivos de tu proyecto:
   - passenger_wsgi.py
   - app.py
   - main.py
   - requirements.txt
   - Carpeta `app/` completa
   - Carpeta `app/routes/`
   - Carpeta `app/templates/`
   - Carpeta `app/static/`

#### Opción B - Usando FTP:

1. Descarga FileZilla: https://filezilla-project.org/
2. Conecta con credenciales FTP de Namecheap:
   - **Host:** ftp.tudominio.com
   - **Usuario:** [tu usuario FTP]
   - **Password:** [tu password FTP]
   - **Puerto:** 21
3. Sube todos los archivos a `public_html` o tu carpeta

#### Opción C - Usando Git en SSH (si tienes acceso):

```bash
# Conectar por SSH
ssh tu-usuario@tudominio.com

# Ir a tu directorio web
cd public_html

# Clonar tu repositorio
git clone https://github.com/kallmaxsystem-max/sys-Kallmax.git .

# O actualizar si ya existe
git pull origin main
```

---

### PASO 4: Configurar entorno virtual en Namecheap

#### 4.1 En cPanel:

1. Busca **"Setup Python App"** o **"Python"**
2. Click en **"Create Application"**
3. Configura:
   - **Python version:** 3.9 o 3.11
   - **Application root:** /public_html
   - **Application URL:** Tu dominio
   - **Application startup file:** passenger_wsgi.py
   - **Application Entry point:** application

#### 4.2 O por SSH:

```bash
# Crear entorno virtual
cd ~/public_html
virtualenv -p python3.9 venv

# Activar entorno virtual
source venv/bin/activate

# Instalar dependencias
pip install -r requirements.txt

# Desactivar
deactivate
```

---

### PASO 5: Configurar SECRET_KEY en Namecheap

Tienes dos opciones:

#### Opción A - Archivo .env (RECOMENDADO):

```bash
# Crear archivo .env en public_html
cd ~/public_html
nano .env
```

Añade:
```
SECRET_KEY=7c705c25adc799bf3444babc43da4bb48fe11dfee5dd826a242ad7f5b71533cd
DEBUG=False
```

Guarda: `Ctrl+X`, `Y`, `Enter`

Luego actualiza `app/__init__.py` para leer el .env:
```python
from flask import Flask
import os
from dotenv import load_dotenv

load_dotenv()  # Cargar variables de .env

def create_app():
    app = Flask(__name__, template_folder='templates', static_folder='static')
    app.secret_key = os.environ.get('SECRET_KEY', 'fallback-key')
    # ... resto del código
```

Y añade `python-dotenv` a requirements.txt:
```txt
Flask==3.0.3
mysql-connector-python==8.3.0
Werkzeug==3.0.3
gunicorn==22.0.0
python-dotenv==1.0.0
```

#### Opción B - Hardcoded (menos seguro):

Edita `app/__init__.py` directamente:
```python
app.secret_key = '7c705c25adc799bf3444babc43da4bb48fe11dfee5dd826a242ad7f5b71533cd'
```

---

### PASO 6: Reiniciar la aplicación

#### En cPanel:
1. Ve a **"Setup Python App"**
2. Click en **"Restart"** junto a tu aplicación

#### Por SSH:
```bash
touch tmp/restart.txt
```

O:
```bash
# Reiniciar Passenger
passenger-config restart-app /home/usuario/public_html
```

---

### PASO 7: Verificar funcionamiento

1. Abre tu navegador
2. Ve a tu dominio: `https://tudominio.com`
3. Deberías ver tu aplicación Kallmax

---

## 🆘 Troubleshooting Namecheap:

### Error 500:
```
Causa: Problema con passenger_wsgi.py o permisos
Solución: 
- Verificar que passenger_wsgi.py tenga permisos 755
- Revisar logs en ~/logs/
```

### Error "No module named 'app'":
```
Causa: Carpeta app/ no subida o ruta incorrecta
Solución: Verificar que app/__init__.py existe
```

### Error de permisos:
```bash
# Dar permisos correctos
chmod 755 passenger_wsgi.py
chmod -R 755 app/
```

---

## 🤔 ¿Qué opción elegir?

### Elige Railway (Opción 1) si:
- ✅ Quieres actualizaciones automáticas desde Git
- ✅ Prefieres infraestructura moderna
- ✅ Necesitas escalabilidad
- ✅ Quieres menos mantenimiento

### Elige Namecheap (Opción 2) si:
- ✅ Ya pagaste hosting en Namecheap y quieres usarlo
- ✅ Prefieres control total del servidor
- ✅ Tienes experiencia con cPanel/Passenger

---

## 💡 Recomendación:

**Usa Opción 1 (Railway + Dominio de Namecheap)**

Razones:
1. Railway ya está funcionando
2. Solo necesitas configurar DNS (5 minutos)
3. Actualizaciones automáticas con Git
4. HTTPS gratis
5. Más rápido y confiable

Puedes mantener tu dominio en Namecheap, solo apuntarlo a Railway.

---

## 📞 ¿Qué prefieres hacer?

1. **Opción 1:** Apuntar dominio de Namecheap a Railway
2. **Opción 2:** Desplegar en hosting de Namecheap

Avísame cuál prefieres y te guío paso a paso con capturas si necesitas.
