# 🔧 Solución de Problemas - Railway Build Failed

## ✅ Cambios realizados para solucionar el error

### 1. Actualizaciones de archivos:
- ✅ **requirements.txt** - Actualizado a versiones más recientes y compatibles
- ✅ **runtime.txt** - Cambiado a Python 3.11.9 (versión estable en Railway)
- ✅ **Procfile** - Configuración simplificada de gunicorn
- ❌ **Eliminado nixpacks.toml** - Dejamos que Railway detecte automáticamente
- ❌ **Eliminado railway.toml** - Usaremos configuración por defecto

### 2. Estructura correcta:
```
sys-Kallmax/
├── main.py              ← Punto de entrada
├── app/
│   ├── __init__.py      ← create_app()
│   └── routes/
│       └── __init__.py  ← Blueprints
├── requirements.txt     ← Dependencias actualizadas
├── runtime.txt          ← python-3.11.9
├── Procfile            ← web: gunicorn main:app
└── .railwayignore      ← Archivos a ignorar
```

---

## 🚀 Pasos para redesplegar

### Opción A: Desde Git (Recomendado)

```bash
# 1. Agregar todos los cambios
git add .

# 2. Commit
git commit -m "Fix: Actualizar dependencias y configuración para Railway"

# 3. Push
git push origin main
```

Railway detectará el push y redesplegará automáticamente.

---

### Opción B: Redespliegue manual en Railway

1. Ve a tu proyecto en Railway
2. Click en **"Deployments"**
3. Click en **"Deploy"** o **"Redeploy"**

---

## 🔍 Verificar los logs de build

Si el build vuelve a fallar, necesitamos ver los logs:

### En Railway Dashboard:

1. Ve a tu proyecto
2. Click en **"Deployments"**
3. Click en el último deployment (el que falló)
4. Click en **"View Logs"**
5. Busca líneas rojas o que digan "ERROR"

### Errores comunes y soluciones:

#### Error 1: "No module named 'app'"
**Causa:** Railway no encuentra el directorio app/
**Solución:** Asegúrate de que la carpeta `app/` esté en Git:
```bash
git add app/
git commit -m "Agregar carpeta app"
git push
```

#### Error 2: "Requirements.txt not found"
**Causa:** El archivo no está en la raíz del proyecto
**Solución:** Verifica que `requirements.txt` esté en la raíz (mismo nivel que main.py)

#### Error 3: "Python version not found"
**Causa:** La versión especificada en runtime.txt no está disponible
**Solución:** Ya actualizado a python-3.11.9

#### Error 4: "Error installing mysql-connector-python"
**Causa:** Falta dependencia del sistema
**Solución:** Railway debería instalarla automáticamente, pero si falla, crea un archivo `nixpacks.toml`:

```toml
[phases.setup]
aptPkgs = ['default-libmysqlclient-dev', 'pkg-config']
nixPkgs = ['python311']

[phases.install]
cmds = ['pip install -r requirements.txt']

[start]
cmd = 'gunicorn main:app --bind 0.0.0.0:$PORT'
```

#### Error 5: "Gunicorn workers failed"
**Causa:** Configuración de workers incorrecta
**Solución:** Ya simplificado en el Procfile

---

## 📋 Checklist de verificación

Antes de redesplegar, verifica:

- [ ] El archivo `main.py` existe en la raíz
- [ ] La carpeta `app/` con `__init__.py` existe
- [ ] `requirements.txt` está en la raíz
- [ ] `runtime.txt` dice `python-3.11.9`
- [ ] `Procfile` dice `web: gunicorn main:app --bind 0.0.0.0:$PORT --workers 4`
- [ ] Todos los archivos están en Git (git status)
- [ ] Has hecho push a la rama correcta (main o master)

---

## 🧪 Probar localmente antes de desplegar

```cmd
# 1. Instalar dependencias
pip install -r requirements.txt

# 2. Probar con gunicorn (igual que Railway)
set PORT=5000
gunicorn main:app --bind 0.0.0.0:5000

# 3. Abrir navegador en http://localhost:5000
```

Si funciona localmente con gunicorn, debería funcionar en Railway.

---

## 🆘 Si nada funciona

### Prueba con configuración mínima:

1. **Crea un archivo `nixpacks.toml` simple:**

```toml
[phases.setup]
nixPkgs = ['python311']

[phases.install]
cmds = ['pip install -r requirements.txt']

[start]
cmd = 'gunicorn main:app --bind 0.0.0.0:$PORT'
```

2. **Simplifica requirements.txt temporalmente:**

```txt
Flask==3.0.3
gunicorn==22.0.0
```

3. **Redespliega y verifica que funcione**

4. **Si funciona, añade mysql-connector-python:**

```txt
Flask==3.0.3
gunicorn==22.0.0
mysql-connector-python==8.3.0
```

---

## 📸 Enviar logs para diagnóstico

Si sigue fallando, copia los logs de build y búscame con:

1. Los logs completos del build
2. Captura de pantalla del error
3. El contenido de estos archivos:
   - `main.py`
   - `requirements.txt`
   - `Procfile`
   - `runtime.txt`

---

## 🔄 Comandos útiles

```bash
# Ver archivos que se subirán a Git
git status

# Ver archivos ignorados
git status --ignored

# Forzar agregar un archivo
git add -f archivo.py

# Ver último commit
git log -1

# Ver diferencias
git diff
```

---

## ✨ Próximos pasos

Una vez que el build sea exitoso:

1. Configurar la variable `SECRET_KEY` en Railway
2. Verificar que la app cargue en la URL de Railway
3. Probar todas las rutas principales
4. Configurar base de datos si es necesario

---

**Última actualización:** 2026-06-24
