# 🚀 Migración de Base de Datos - KallMax

## ✅ ¿Qué se hizo?

Se migró la base de datos del servidor antiguo (209.74.89.191) al servidor MySQL de Namecheap (localhost).

### Cambios realizados:
- ✅ Base de datos importada en Namecheap: `kallgwkn_kallmax_bd`
- ✅ Código actualizado para usar variables de entorno (.env)
- ✅ Archivos preparados para local y producción

---

## 📝 Configurar Local (opcional)

Si quieres probar en tu computadora:

1. Editar archivo `.env` en la raíz del proyecto
2. Cambiar esta línea:
   ```
   DB_PASSWORD=TU_PASSWORD_AQUI
   ```
3. Ejecutar:
   ```bash
   python verificar_conexion.py
   ```

---

## 🚀 Actualizar Producción (Namecheap)

### Paso 1: Abrir WinSCP

- **Host:** 162.213.251.186
- **Usuario:** kallgwkn
- **Contraseña:** #215292159xD

### Paso 2: Subir 3 archivos

Desde la carpeta `namecheap_deploy\app\` subir a `/home/kallgwkn/kallmax_app/app/`:

1. **config.py** → `/home/kallgwkn/kallmax_app/app/config.py`
2. **routes\auth.py** → `/home/kallgwkn/kallmax_app/app/routes/auth.py`
3. **funciones\register_user.py** → `/home/kallgwkn/kallmax_app/app/funciones/register_user.py`

### Paso 3: Editar .env en producción

En WinSCP, abrir: `/home/kallgwkn/kallmax_app/.env`

Debe tener este contenido:

```env
# Flask Configuration
SECRET_KEY=7c705c25adc799bf3444babc43da4bb48fe11dfee5dd826a242ad7f5b71533cd
DEBUG=False

# Database Configuration
DB_HOST=localhost
DB_PORT=3306
DB_USER=kallgwkn_user
DB_PASSWORD=TU_PASSWORD_MYSQL
DB_NAME=kallgwkn_kallmax_bd
```

**¿Dónde obtener el password?**
- Ir a **cPanel**
- **MySQL Databases**
- Buscar usuario: **kallgwkn_user**
- Click **Change Password**
- Copiar el password y pegarlo en `.env`

### Paso 4: Reiniciar la aplicación

**Opción A (Recomendada):**
- En cPanel → **Setup Python App**
- Buscar: `kallmax_app`
- Click: **Restart**

**Opción B (SSH):**
```bash
touch ~/kallmax_app/tmp/restart.txt
```

### Paso 5: Verificar

1. Abrir: **https://kallmaxcorredores.com**
2. Intentar hacer login
3. ✅ Debe funcionar correctamente

---

## 📊 Credenciales de Base de Datos

### Producción (Namecheap):
```
Host: localhost
Port: 3306
User: kallgwkn_user
Database: kallgwkn_kallmax_bd
Password: [Obtener desde cPanel]
```

---

## 🔍 Verificar Logs

Si hay problemas, revisar logs en:
```
/home/kallgwkn/kallmax_app/logs/kallmax.log
```

Ver últimas líneas:
```bash
tail -f ~/kallmax_app/logs/kallmax.log
```

---

## 📚 Archivos de Ayuda

- **`INSTRUCCIONES_ACTUALIZAR_BD.md`** - Guía detallada
- **`RESUMEN_MIGRACION_BD.txt`** - Resumen visual
- **`verificar_conexion.py`** - Script de verificación

---

## ❓ Preguntas Frecuentes

**P: ¿Necesito cambiar algo en Railway?**
R: No, Railway sigue igual. Solo se actualizó la conexión de Namecheap.

**P: ¿Qué pasa si no tengo el password de MySQL?**
R: Ve a cPanel → MySQL Databases → Change Password para el usuario `kallgwkn_user`

**P: ¿Cómo sé si funcionó?**
R: Intenta hacer login en https://kallmaxcorredores.com

**P: ¿Dónde está el backup de la BD antigua?**
R: En `kallmax_backup_fixed.sql` (ya importado en Namecheap)

---

## 🆘 Soporte

Si hay problemas:
1. Revisar logs: `/home/kallgwkn/kallmax_app/logs/kallmax.log`
2. Verificar que el password en `.env` sea correcto
3. Verificar que los 3 archivos se hayan subido correctamente
4. Reiniciar la aplicación en cPanel

---

**✅ La base de datos ya está importada. Solo falta actualizar el código y configurar .env**
