# 📋 CAMBIOS: Tipos de Seguimiento Dinámicos

**Fecha**: 27 Junio 2026
**Feature**: Cargar tipos de seguimiento desde SP en modal "Registrar Seguimiento"
**Estado**: ✅ COMPLETADO

---

## 📝 Descripción del Cambio

El campo "Tipo de Seguimiento" en el modal "Registrar Seguimiento" ahora carga dinámicamente desde la tabla `TblTipoSeguimientoCliente` a través de un SP, en lugar de tener valores hardcodeados.

### Antes:
```html
<select name="id_tipo_seguimiento" required>
    <option value="">Seleccionar...</option>
    <option value="1">Llamada</option>
    <option value="2">Email</option>
    <option value="3">Reunión</option>
    <option value="4">Propuesta</option>
    <option value="5">Cotización</option>
</select>
```

### Después:
```html
<select id="selectTipoSeguimiento" name="id_tipo_seguimiento" required>
    <option value="">Cargando tipos...</option>
</select>
```

Con función JavaScript que carga dinámicamente:
```javascript
async function cargarTiposSeguimiento() {
    const response = await fetch('/api/tipos-seguimiento');
    // Llenar el select con datos de la API
}
```

---

## 🔧 Cambios Técnicos

### 1. Base de Datos
**SP**: `sp_ListarTiposSeguimiento`
- Ya existía en el sistema
- Retorna: `id_tipo_seguimiento`, `nombre`
- Tabla: `TblTipoSeguimientoCliente`

### 2. Backend (Python)
**Función**: `listar_tipos_seguimiento_api()`
- Ubicación: `app/funciones/clientes.py` (línea ~507)
- Ya existía en el sistema
- Llama al SP `sp_ListarTiposSeguimiento`

### 3. Rutas Flask
**Endpoint**: `GET /api/tipos-seguimiento`
- Ubicación: `app/routes/main.py` (línea ~364)
- Ya existía en el sistema
- Protegida con `@login_required`

### 4. Frontend (HTML/JS)
**Archivo**: `app/templates/clients.html`

#### Cambios HTML:
- **Línea ~384**: Agregado `id="selectTipoSeguimiento"`
- **Línea ~387**: Cambio de contenido: `Cargando tipos...`
- **Líneas removidas**: Valores hardcodeados (Llamada, Email, Reunión, etc.)

#### Cambios JavaScript:
- **Línea ~857**: Nueva llamada a `cargarTiposSeguimiento()` en `abrirHistorialSeguimientos()`
- **Línea ~873**: Nueva función `cargarTiposSeguimiento()`

---

## 📊 Detalles de la Función JavaScript

### `cargarTiposSeguimiento()`
```javascript
async function cargarTiposSeguimiento() {
    try {
        const selectTipo = document.getElementById('selectTipoSeguimiento');
        selectTipo.innerHTML = '<option value="">Cargando tipos...</option>';
        
        // Llamar al endpoint API
        const response = await fetch('/api/tipos-seguimiento');
        
        if (!response.ok) {
            throw new Error('Error al cargar tipos de seguimiento');
        }
        
        const result = await response.json();
        
        if (result.success && result.data && result.data.length > 0) {
            // Limpiar y llenar select
            selectTipo.innerHTML = '<option value="">Seleccionar tipo...</option>';
            
            result.data.forEach(tipo => {
                const option = document.createElement('option');
                option.value = tipo.id_tipo_seguimiento;
                option.textContent = tipo.nombre;
                selectTipo.appendChild(option);
            });
        } else {
            selectTipo.innerHTML = '<option value="">No hay tipos disponibles</option>';
        }
    } catch (error) {
        console.error('Error al cargar tipos de seguimiento:', error);
        const selectTipo = document.getElementById('selectTipoSeguimiento');
        selectTipo.innerHTML = '<option value="">Error al cargar tipos</option>';
    }
}
```

---

## 🔄 Flujo de Funcionamiento

```
1. Usuario hace clic en icono de archivo (📎) en tabla de clientes
                ↓
2. Se ejecuta: abrirHistorialSeguimientos(numDocumento)
                ↓
3. Se abre modal "Registrar Seguimiento"
                ↓
4. Se llama: cargarTiposSeguimiento()
                ↓
5. Fetch a: GET /api/tipos-seguimiento
                ↓
6. Flask llama a: listar_tipos_seguimiento_api()
                ↓
7. Función ejecuta: CALL sp_ListarTiposSeguimiento()
                ↓
8. MySQL retorna tipos de TblTipoSeguimientoCliente
                ↓
9. JavaScript recibe JSON y llena el <select>
                ↓
10. Usuario ve desplegable con opciones dinámicas
```

---

## ✅ Validación

### En BD
```sql
SELECT id_tipo_seguimiento, nombre FROM TblTipoSeguimientoCliente;
```
**Esperado**: Ver todas las tipos disponibles

### API Endpoint
```bash
curl -H "Authorization: Bearer TOKEN" \
     http://localhost:5000/api/tipos-seguimiento
```
**Esperado**: JSON con array de tipos

### En Navegador
1. Abrir modal "Registrar Seguimiento"
2. Ver desplegable "Tipo de Seguimiento" poblado dinámicamente
3. F12 → Console (sin errores)
4. F12 → Network → Verificar request a `/api/tipos-seguimiento`

---

## 🎯 Beneficios

| Aspecto | Beneficio |
|--------|----------|
| **Flexibilidad** | Agregar/quitar tipos sin cambiar código |
| **Mantenimiento** | Cambios en BD se reflejan automáticamente |
| **Escalabilidad** | Funciona con cualquier número de tipos |
| **UX** | Datos siempre actualizados |
| **Admin** | Control total desde BD |

---

## 📝 Archivos Modificados

- `app/templates/clients.html`
  - Actualizar select HTML
  - Agregar función `cargarTiposSeguimiento()`
  - Llamar función en `abrirHistorialSeguimientos()`

---

## 🚀 Para Producción

### Paso 1: Verificar SP existe
```sql
SHOW CREATE PROCEDURE sp_ListarTiposSeguimiento;
```

### Paso 2: Subir archivo actualizado
```bash
cp app/templates/clients.html /servidor/app/templates/
```

### Paso 3: Reiniciar Flask
```bash
supervisorctl restart kallmax
```

### Paso 4: Validar
1. Acceder a clientes
2. Abrir modal de seguimiento
3. Verificar que desplegable carga tipos dinámicamente

---

## 🐛 Troubleshooting

### Desplegable muestra "Error al cargar tipos"
- Verificar que endpoint `/api/tipos-seguimiento` responde
- Revisar logs de Flask
- Verificar que SP existe

### Desplegable vacío
- Verificar que `TblTipoSeguimientoCliente` tiene datos
- Ejecutar: `SELECT * FROM TblTipoSeguimientoCliente;`

### No se ve cambio después de actualizar
- Limpiar cache: Ctrl+Shift+Delete
- Hard refresh: Ctrl+Shift+R

---

## 📄 Archivos SQL Relacionados

### `sp_ListarTiposSeguimiento.sql` (Nuevo - opcional)
Creado como referencia, pero el SP ya existe en el sistema.

```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ListarTiposSeguimiento$$
CREATE PROCEDURE sp_ListarTiposSeguimiento()
BEGIN
    SELECT 
        id_tipo_seguimiento,
        nombre
    FROM TblTipoSeguimientoCliente
    ORDER BY id_tipo_seguimiento ASC;
END$$
DELIMITER ;
```

---

## 📞 Información de Contacto

Para preguntas sobre este cambio:
- Revisar logs: `tail -f /var/log/kallmax/kallmax_app.log`
- Verificar BD: `SHOW PROCEDURES LIKE '%Tipos%';`
- Inspeccionar navegador: F12 → Console

---

**Versión**: 1.0
**Estado**: LISTO
**Fecha**: 27 Junio 2026
