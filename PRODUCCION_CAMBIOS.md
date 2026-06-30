# 📦 CAMBIOS PARA SUBIR A PRODUCCIÓN
## Commit: b460284 - Últimos 3 Seguimientos

Fecha: 27 de Junio 2026
Descripción: Implementar Últimos 3 Seguimientos en modal Registrar Seguimiento con SP

---

## 📋 ARCHIVOS A SUBIR

### 1️⃣ ARCHIVO SQL - CREAR SP EN BD
**Archivo**: `sp_Ultimos3Seguimientos.sql`
**Acción**: Ejecutar en MySQL (Una sola vez)
**Ubicación en servidor**: No necesario subir, solo ejecutar el SQL

```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Ultimos3Seguimientos$$
CREATE PROCEDURE sp_Ultimos3Seguimientos(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        cs.id_seguimiento,
        cs.num_documento,
        cs.id_tipo_seguimiento,
        tsc.nombre AS tipo_seguimiento,
        cs.fecha_seguimiento,
        cs.observacion,
        cs.realizado_por,
        CONCAT(COALESCE(p.nombres, ''), ' ', COALESCE(p.apellido_paterno, ''), ' ', COALESCE(p.apellido_materno, '')) AS nombre_asesor,
        cs.estado,
        cs.fecha_registro
    FROM TblClientesSeguimientos cs
    INNER JOIN TblTipoSeguimientoCliente tsc ON cs.id_tipo_seguimiento = tsc.id_tipo_seguimiento
    LEFT JOIN TblPersona p ON cs.realizado_por = p.num_documento
    WHERE cs.num_documento = p_num_documento
    ORDER BY cs.fecha_seguimiento DESC
    LIMIT 3;
END$$
DELIMITER ;
```

---

### 2️⃣ ARCHIVO PYTHON - BACKEND
**Archivo**: `app/funciones/clientes.py`
**Acción**: Subir archivo completo
**Ubicación en servidor**: `/app/funciones/clientes.py`
**Cambios**: 
- Agregada función: `listar_ultimos_3_seguimientos_api(num_documento)`
- Líneas: ~54 nuevas líneas (entre línea 606-660)

---

### 3️⃣ ARCHIVO RUTAS - API ENDPOINTS
**Archivo**: `app/routes/main.py`
**Acción**: Subir archivo completo
**Ubicación en servidor**: `/app/routes/main.py`
**Cambios**:
- Agregado import: `listar_ultimos_3_seguimientos_api` (línea 48)
- Agregada ruta: `GET /api/ultimos-3-seguimientos/<num_documento>` (líneas 378-382)

---

### 4️⃣ ARCHIVO TEMPLATE - INTERFAZ
**Archivo**: `app/templates/clients.html`
**Acción**: Subir archivo completo
**Ubicación en servidor**: `/app/templates/clients.html`
**Cambios**:
- Agregada sección HTML: "Últimos 3 Seguimientos" (líneas 415-425)
- Actualizada función JS: `mostrarUltimos3Seguimientos()` (líneas 869-923)
- Actualizada función JS: `abrirHistorialSeguimientos()` (línea 865)

---

## 🚀 PASOS PARA IMPLEMENTAR EN PRODUCCIÓN

### PASO 1: Crear el SP en la BD de Producción
```bash
# Con túnel SSH activo (si aplica)
ssh -L 3307:127.0.0.1:3306 kallgwkn@162.213.251.186 -p 21098

# En otra terminal
mysql -h 127.0.0.1 -P 3307 -u kallgwkn_user -p kallgwkn_kallmax_bd < sp_Ultimos3Seguimientos.sql
```

O ejecutar directamente en MySQL:
```sql
USE kallgwkn_kallmax_bd;
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_Ultimos3Seguimientos$$
CREATE PROCEDURE sp_Ultimos3Seguimientos(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        cs.id_seguimiento,
        cs.num_documento,
        cs.id_tipo_seguimiento,
        tsc.nombre AS tipo_seguimiento,
        cs.fecha_seguimiento,
        cs.observacion,
        cs.realizado_por,
        CONCAT(COALESCE(p.nombres, ''), ' ', COALESCE(p.apellido_paterno, ''), ' ', COALESCE(p.apellido_materno, '')) AS nombre_asesor,
        cs.estado,
        cs.fecha_registro
    FROM TblClientesSeguimientos cs
    INNER JOIN TblTipoSeguimientoCliente tsc ON cs.id_tipo_seguimiento = tsc.id_tipo_seguimiento
    LEFT JOIN TblPersona p ON cs.realizado_por = p.num_documento
    WHERE cs.num_documento = p_num_documento
    ORDER BY cs.fecha_seguimiento DESC
    LIMIT 3;
END$$
DELIMITER ;
```

### PASO 2: Verificar que el SP fue creado
```sql
SHOW CREATE PROCEDURE sp_Ultimos3Seguimientos;
CALL sp_Ultimos3Seguimientos('73017548');
```

### PASO 3: Subir archivos Python y Template
Reemplazar en servidor:
- `app/funciones/clientes.py`
- `app/routes/main.py`
- `app/templates/clients.html`

### PASO 4: Reiniciar aplicación Flask
```bash
# Si usa supervisord
supervisorctl restart kallmax

# Si usa systemd
systemctl restart kallmax

# Si usa manual
# Detener Flask actual y reiniciar
```

### PASO 5: Validar en Producción
1. Abrir navegador: `https://tudominio.com/clientes`
2. Hacer clic en icono de archivo en cualquier cliente
3. Debe aparecer "Últimos 3 Seguimientos" debajo del formulario
4. Verificar que se cargan los últimos 3 seguimientos

---

## ✅ CHECKLIST DE VALIDACIÓN

- [ ] SP creado en BD de producción
- [ ] SP retorna 3 registros máximo
- [ ] Archivos Python subidos
- [ ] Archivos Template subidos
- [ ] Flask reiniciado
- [ ] Endpoint `/api/ultimos-3-seguimientos/{num_documento}` responde
- [ ] Modal "Registrar Seguimiento" muestra últimos 3 seguimientos
- [ ] Sin errores en consola del navegador (F12)
- [ ] Sin errores en logs de Flask

---

## 📝 NOTAS IMPORTANTES

1. **Base de Datos**: El SP SOLO se crea una vez en BD. No recargar.
2. **Python/Template**: Los archivos `.py` y `.html` se pueden reemplazar múltiples veces.
3. **Reinicio Flask**: Necesario después de cambiar archivos Python.
4. **Sin cache**: Usar Ctrl+Shift+Delete en navegador para limpiar cache.
5. **Backup**: Hacer backup de la BD antes de crear el SP.

---

## 🔍 RESUMEN DE CAMBIOS

| Archivo | Tipo | Líneas | Descripción |
|---------|------|--------|-------------|
| `sp_Ultimos3Seguimientos.sql` | SQL | 31 | Nuevo SP |
| `app/funciones/clientes.py` | Python | +54 | Nueva función API |
| `app/routes/main.py` | Python | +12 | Nueva ruta y import |
| `app/templates/clients.html` | HTML/JS | +260 | UI y JavaScript |

Total: **4 archivos modificados**

---

## 📞 SOPORTE

Si hay problemas:
1. Verificar SP está creado: `SHOW PROCEDURES LIKE 'sp_Ultimos3%';`
2. Verificar Flask conecta: Ver logs de Flask
3. Verificar endpoint: `curl http://localhost:5000/api/ultimos-3-seguimientos/73017548`
4. Ver consola navegador: F12 → Console → Network

---

**Versión**: 1.0
**Fecha**: 27 Jun 2026
**Autor**: Sistema Kallmax
**Commit Git**: b460284
