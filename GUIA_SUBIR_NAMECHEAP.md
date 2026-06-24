# 📤 Guía para Subir tu App a Namecheap Hosting

## 📋 Información que necesitas tener lista:

Antes de empezar, ten a mano:
- ✅ Usuario de cPanel de Namecheap
- ✅ Contraseña de cPanel
- ✅ Tu dominio (ej: kallmax.com)
- ✅ Credenciales FTP (si vas a usar FTP)

---

## 🎯 Método Recomendado: cPanel File Manager

### PASO 1: Acceder a cPanel

1. Inicia sesión en Namecheap: https://www.namecheap.com/
2. Ve a **"Hosting List"** o **"Dashboard"**
3. Click en **"Manage"** o **"cPanel"** junto a tu hosting
4. Se abrirá el panel de control cPanel

---

### PASO 2: Limpiar carpeta actual (si hay archivos viejos)

1. En cPanel, busca y abre **"File Manager"**
2. Navega a la carpeta de tu dominio:
   - Normalmente es `public_html` o
   - `public_html/tudominio.com`
3. Selecciona todos los archivos viejos (si hay)
4. Click en **"Delete"** para eliminarlos
5. Confirma la eliminación

---

### PASO 3: Subir archivos del proyecto

#### 3.1 Crear archivo ZIP de tu proyecto (en tu PC):

En tu computadora local:

1. Abre el explorador de archivos
2. Ve a: `D:\kallpa\sys-Kallmax`
3. Selecciona ESTOS archivos y carpetas:
   ```
   ✅ passenger_wsgi.py
   ✅ app.py
   ✅ main.py
   ✅ requirements.txt
   ✅ Carpeta: app/
   ✅ .env.example (opcional)
   ```

4. **NO incluir:**
   ```
   ❌ .git/
   ❌ __pycache__/
   ❌ venv/
   ❌ .gitignore
   ❌ Procfile
   ❌ nixpacks.toml
   ❌ .mise.toml
   ❌ archivos .md de documentación
   ❌ iniciar.bat
   ❌ generar_secret_key.py
   ❌ test_railway_local.bat
   ```

5. Click derecho en los archivos seleccionados
6. **"Enviar a"** → **"Carpeta comprimida (en zip)"**
7. Nómbralo: `kallmax-app.zip`

#### 3.2 Subir ZIP a cPanel:

1. En cPanel File Manager, ve a tu carpeta web (`public_html`)
2. Click en el botón **"Upload"** (arriba)
3. Se abre la página de subida
4. Click en **"Select File"**
5. Selecciona `kallmax-app.zip` que acabas de crear
6. Espera a que suba (puede tomar 1-3 minutos)
7. Cuando termine, verás "100% Complete"
8. Click en **"Go Back to..."** para volver al File Manager

#### 3.3 Extraer archivos:

1. En File Manager, busca el archivo `kallmax-app.zip`
2. Click derecho sobre él
3. Selecciona **"Extract"**
4. Confirma la extracción
5. Espera a que se extraiga
6. Click en **"Close"** cuando termine
7. Ahora puedes eliminar el `kallmax-app.zip` (ya no lo necesitas)

---

### PASO 4: Configurar Python Application

#### 4.1 Abrir Python App Manager:

1. Vuelve al Dashboard de cPanel (click en el logo o "Home")
2. Busca en la barra de búsqueda: **"Python"** o **"Setup Python App"**
3. Click en **"Setup Python App"** (icono de Python)

#### 4.2 Crear nueva aplicación:

1. Click en el botón **"Create Application"**
2. Completa el formulario:

```
Python version: 3.11 (o la más alta disponible, mínimo 3.9)

Application root: /home/TU_USUARIO/public_html
(Reemplaza TU_USUARIO con tu nombre de usuario real)

Application URL: Tu dominio (ej: kallmax.com)
O déjalo en blanco si es el dominio principal

Application startup file: passenger_wsgi.py

Application Entry point: application

Passenger log file: (déjalo vacío o en blanco)
```

3. Click en **"Create"** o **"Save"**

#### 4.3 Anotar información importante:

Después de crear la app, verás:
```
Virtual environment path: /home/TU_USUARIO/virtualenv/...
Python version: 3.11.x
```

**IMPORTANTE:** Anota esta ruta del virtual environment.

---

### PASO 5: Actualizar passenger_wsgi.py con la ruta correcta

#### 5.1 En File Manager:

1. Navega a `public_html`
2. Click derecho en **"passenger_wsgi.py"**
3. Selecciona **"Edit"**
4. Busca esta línea:
```python
INTERP = os.path.join(os.environ.get('HOME', '/home/kallgwkn'), 'virtualenv', 'kallmax_app', '3.9', 'bin', 'python3')
```

5. Reemplázala con la ruta que anotaste arriba (algo como):
```python
INTERP = os.path.join(os.environ.get('HOME', '/home/TU_USUARIO'), 'virtualenv', 'public_html', '3.11', 'bin', 'python3')
```

**IMPORTANTE:** Ajusta según lo que te mostró Python App Manager.

6. Click en **"Save Changes"**
7. Cierra el editor

---

### PASO 6: Instalar dependencias

#### 6.1 Acceder a Terminal:

**Opción A - Terminal en cPanel (si está disponible):**
1. En cPanel, busca **"Terminal"**
2. Click para abrir

**Opción B - SSH (más común en Namecheap):**
1. Primero habilita SSH:
   - En cPanel busca **"SSH Access"**
   - Click en **"Manage SSH Keys"**
   - Sigue las instrucciones para habilitar

2. En tu PC, abre PowerShell o CMD:
```cmd
ssh tu_usuario@tudominio.com
```
O:
```cmd
ssh tu_usuario@servidor.namecheaphosting.com
```

(Namecheap te da esta información en el panel de hosting)

#### 6.2 Instalar dependencias:

Una vez en la terminal SSH o Terminal:

```bash
# Ir a la carpeta de tu aplicación
cd ~/public_html

# Activar el entorno virtual (ajusta la ruta según tu configuración)
source ~/virtualenv/public_html/3.11/bin/activate

# O puede ser:
# source $(cat .python-app-config | grep venv | cut -d= -f2)/bin/activate

# Actualizar pip
pip install --upgrade pip

# Instalar dependencias
pip install -r requirements.txt

# Verificar instalación
pip list

# Desactivar entorno virtual
deactivate
```

Si ves errores con mysql-connector-python, prueba:
```bash
pip install --upgrade setuptools wheel
pip install mysql-connector-python==8.3.0
```

---

### PASO 7: Configurar SECRET_KEY

#### Opción A - Archivo .env (RECOMENDADO):

En File Manager o Terminal:

```bash
# Crear archivo .env
cd ~/public_html
nano .env
```

Añade:
```env
SECRET_KEY=7c705c25adc799bf3444babc43da4bb48fe11dfee5dd826a242ad7f5b71533cd
DEBUG=False
```

Guarda: `Ctrl+X`, `Y`, `Enter`

Luego instala python-dotenv:
```bash
source ~/virtualenv/public_html/3.11/bin/activate
pip install python-dotenv
deactivate
```

Y actualiza `app/__init__.py` para usar .env:
```python
from flask import Flask
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv()

def create_app():
    app = Flask(__name__, template_folder='templates', static_folder='static')
    
    # Usar SECRET_KEY del .env
    app.secret_key = os.environ.get('SECRET_KEY', 'fallback-key-change-this')
    
    # ... resto del código
```

#### Opción B - Hardcoded (menos seguro pero más simple):

Edita directamente `app/__init__.py` y cambia:
```python
app.secret_key = '7c705c25adc799bf3444babc43da4bb48fe11dfee5dd826a242ad7f5b71533cd'
```

---

### PASO 8: Configurar permisos

En Terminal o SSH:

```bash
cd ~/public_html

# Dar permisos correctos
chmod 755 passenger_wsgi.py
chmod 755 main.py
chmod -R 755 app/
```

---

### PASO 9: Reiniciar la aplicación

#### En Python App Manager:
1. Ve a cPanel → Setup Python App
2. Busca tu aplicación en la lista
3. Click en el icono de **"Restart"** (⟳) o botón "Restart"

#### O en Terminal:
```bash
cd ~/public_html
touch tmp/restart.txt
```

O:
```bash
mkdir -p tmp
touch tmp/restart.txt
```

---

### PASO 10: Verificar funcionamiento

1. Abre tu navegador
2. Ve a tu dominio: `https://tudominio.com`
3. Deberías ver tu aplicación Kallmax funcionando

---

## 🆘 Troubleshooting

### Error 500 - Internal Server Error

**Revisar logs:**
```bash
# En SSH/Terminal
cd ~/logs
cat error_log | tail -50
```

O en cPanel → Metrics → Errors

**Causas comunes:**
1. Ruta incorrecta en passenger_wsgi.py
2. Permisos incorrectos
3. Dependencias no instaladas
4. Error en el código

**Soluciones:**
```bash
# Verificar que passenger_wsgi.py tenga la ruta correcta
# Reinstalar dependencias
cd ~/public_html
source ~/virtualenv/public_html/3.11/bin/activate
pip install --force-reinstall -r requirements.txt
deactivate

# Reiniciar
touch tmp/restart.txt
```

### Error "No module named 'app'"

**Causa:** Carpeta app/ no está en el lugar correcto

**Solución:**
```bash
cd ~/public_html
ls -la app/
# Deberías ver: __init__.py, routes/, templates/, static/
```

Si no está, verifica que subiste la carpeta completa.

### Error "ImportError: No module named 'flask'"

**Causa:** Flask no instalado o entorno virtual no activo

**Solución:**
```bash
cd ~/public_html
source ~/virtualenv/public_html/3.11/bin/activate
pip install Flask
pip install -r requirements.txt
deactivate
touch tmp/restart.txt
```

### La página muestra "Coming Soon" o página de Namecheap

**Causa:** Archivos no están en la carpeta correcta

**Solución:**
Verifica que los archivos estén directamente en `public_html`, no en una subcarpeta.

---

## 🔐 Seguridad

### Proteger archivos sensibles:

Crea un archivo `.htaccess` en `public_html`:

```apache
# Proteger archivos de configuración
<FilesMatch "^(\.env|requirements\.txt|passenger_wsgi\.py|app\.py)$">
    Order allow,deny
    Deny from all
</FilesMatch>

# Proteger carpeta de Python
<DirectoryMatch "^/.*/venv/">
    Order deny,allow
    Deny from all
</DirectoryMatch>
```

---

## 📚 Comandos útiles

```bash
# Ver logs de error
tail -f ~/logs/error_log

# Ver procesos Python
ps aux | grep python

# Reiniciar app
touch ~/public_html/tmp/restart.txt

# Ver dependencias instaladas
source ~/virtualenv/public_html/3.11/bin/activate
pip list
deactivate

# Verificar estructura
cd ~/public_html
tree -L 2
# O
ls -laR
```

---

## ✅ Checklist final

- [ ] Archivos subidos a public_html
- [ ] Python App creada en cPanel
- [ ] passenger_wsgi.py con ruta correcta
- [ ] Dependencias instaladas (pip install -r requirements.txt)
- [ ] SECRET_KEY configurada
- [ ] Permisos correctos (chmod 755)
- [ ] Aplicación reiniciada
- [ ] Dominio funcionando

---

## 📞 Siguiente paso

Una vez que completes estos pasos, avísame:
- ✅ Si funciona correctamente
- ❌ Si hay algún error (envíame el mensaje de error completo)

Te ayudaré a solucionar cualquier problema.
