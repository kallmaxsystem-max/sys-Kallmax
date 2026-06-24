# 🚀 Guía Rápida: Subir a Namecheap (5 pasos simples)

## ✅ Archivos preparados

Ya tienes todo listo para Namecheap:
- ✅ passenger_wsgi.py (configurado para Namecheap)
- ✅ app.py (con detección de entorno)
- ✅ main.py (punto de entrada)
- ✅ requirements.txt (con dependencias)
- ✅ .env.example (con tu SECRET_KEY ya configurada)
- ✅ Carpeta app/ completa

---

## 🎯 OPCIÓN MÁS FÁCIL: Script Automático

### Paso 1: Ejecutar el script
```cmd
preparar_para_namecheap.bat
```

Esto creará:
- 📦 `kallmax-namecheap.zip` (listo para subir)
- 📁 `namecheap_deploy/` (archivos sin comprimir)

### Paso 2: Subir a Namecheap
1. Ve a cPanel → File Manager
2. Navega a `public_html`
3. Upload → Selecciona `kallmax-namecheap.zip`
4. Click derecho → Extract
5. ¡Listo! Archivos subidos

---

## 📋 OPCIÓN MANUAL: Paso a paso

### Paso 1: Acceder a cPanel

```
1. https://www.namecheap.com/
2. Login
3. Dashboard → Hosting List
4. Click "Manage" o "cPanel"
```

---

### Paso 2: Subir archivos

**Método A - File Manager (más fácil):**

1. En cPanel → **"File Manager"**
2. Ve a `public_html`
3. Click **"Upload"**
4. Sube estos archivos:
   ```
   passenger_wsgi.py
   app.py
   main.py
   requirements.txt
   .env.example (renombrar a .env después)
   ```
5. Crea carpeta `app` y sube contenido:
   ```
   app/__init__.py
   app/funciones/
   app/routes/
   app/templates/
   app/static/
   ```

**Método B - FTP (FileZilla):**

1. Abre FileZilla
2. Conecta:
   - Host: `ftp.tudominio.com`
   - Usuario: [tu usuario FTP]
   - Password: [tu password]
   - Puerto: 21
3. Sube todos los archivos a `/public_html/`

---

### Paso 3: Configurar Python App

En cPanel:

1. Busca **"Setup Python App"** o **"Python"**
2. Click **"Create Application"**
3. Completa:

```
Python version: 3.11 (o mayor disponible)
Application root: /home/TU_USUARIO/public_html
Application URL: [tu dominio]
Application startup file: passenger_wsgi.py
Application Entry point: application
```

4. Click **"Create"**
5. **IMPORTANTE:** Anota la ruta del virtual environment que aparece

---

### Paso 4: Actualizar passenger_wsgi.py

1. En File Manager → `public_html`
2. Click derecho en `passenger_wsgi.py` → **"Edit"**
3. Busca la línea:
```python
INTERP = os.path.join(os.environ.get('HOME', '/home/kallgwkn'), 'virtualenv', 'kallmax_app', '3.9', 'bin', 'python3')
```

4. Cámbiala por (ajusta según tu configuración):
```python
INTERP = os.path.join(os.environ.get('HOME', '/home/TU_USUARIO'), 'virtualenv', 'public_html', '3.11', 'bin', 'python3')
```

**IMPORTANTE:** Usa la ruta que te dio Python App Manager en el paso anterior.

5. Save Changes

---

### Paso 5: Instalar dependencias

**Acceder a Terminal SSH:**

```cmd
ssh tu_usuario@tudominio.com
```

O usa Terminal en cPanel si está disponible.

**En la terminal:**

```bash
# Ir a tu carpeta
cd ~/public_html

# Activar entorno virtual (ajusta la ruta)
source ~/virtualenv/public_html/3.11/bin/activate

# Instalar dependencias
pip install --upgrade pip
pip install -r requirements.txt

# Verificar instalación
pip list | grep Flask

# Desactivar
deactivate
```

---

### Paso 6: Configurar SECRET_KEY

**Opción A - Renombrar .env.example:**

En File Manager:
1. Click derecho en `.env.example`
2. Rename → `.env`
3. ¡Listo! Ya tiene tu SECRET_KEY configurada

**Opción B - Editar directamente:**

1. Edit `.env.example`
2. Verifica que tenga:
```
SECRET_KEY=7c705c25adc799bf3444babc43da4bb48fe11dfee5dd826a242ad7f5b71533cd
DEBUG=False
```
3. Save y renombra a `.env`

---

### Paso 7: Reiniciar aplicación

**En cPanel:**
1. Setup Python App
2. Busca tu app en la lista
3. Click en ícono **"Restart"** (⟳)

**O en Terminal:**
```bash
cd ~/public_html
mkdir -p tmp
touch tmp/restart.txt
```

---

### Paso 8: Verificar

1. Abre navegador
2. Ve a: `https://tudominio.com`
3. ¡Deberías ver tu aplicación Kallmax! 🎉

---

## 🆘 Solución rápida de problemas

### Error 500
```bash
# Ver logs
tail -50 ~/logs/error_log

# Reinstalar dependencias
cd ~/public_html
source ~/virtualenv/public_html/3.11/bin/activate
pip install --force-reinstall -r requirements.txt
deactivate
touch tmp/restart.txt
```

### "No module named 'app'"
```bash
# Verificar estructura
cd ~/public_html
ls -la app/
# Debe mostrar: __init__.py, routes/, templates/, static/
```

### "No module named 'flask'"
```bash
cd ~/public_html
source ~/virtualenv/public_html/3.11/bin/activate
pip install Flask
pip install -r requirements.txt
deactivate
touch tmp/restart.txt
```

---

## 📞 Información necesaria de Namecheap

Para completar el setup, necesitas saber:

1. **Tu usuario de cPanel:** _______________
2. **Tu dominio:** _______________
3. **Ubicación de public_html:** /home/______/public_html
4. **Versión de Python disponible:** 3.___
5. **Ruta del virtualenv:** /home/_____/virtualenv/_____/___/bin/python3

Puedes encontrar esta info en:
- cPanel → Setup Python App (después de crear la app)
- Email de bienvenida de Namecheap
- Dashboard de Namecheap → Hosting Details

---

## ✨ Checklist

- [ ] Archivos subidos a public_html
- [ ] Python App creada en cPanel
- [ ] passenger_wsgi.py editado con ruta correcta
- [ ] Dependencias instaladas (pip install -r requirements.txt)
- [ ] .env configurado con SECRET_KEY
- [ ] Aplicación reiniciada
- [ ] Dominio accesible y funcionando

---

## 🎯 Siguiente paso

**Ejecuta el script:**
```cmd
preparar_para_namecheap.bat
```

Esto creará `kallmax-namecheap.zip` listo para subir a cPanel.

**O sigue la guía manual arriba paso por paso.**

---

## 📚 Documentación completa

Para más detalles, consulta:
- `GUIA_SUBIR_NAMECHEAP.md` - Guía detallada completa
- `CONFIGURAR_DOMINIO_NAMECHEAP.md` - Opciones de dominio

---

**¿Necesitas ayuda? Avísame en qué paso estás y te guío!** 🚀
