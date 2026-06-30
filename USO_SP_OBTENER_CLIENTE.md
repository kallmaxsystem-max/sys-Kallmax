# 📍 USO DE sp_ObtenerClientePorDocumento

## Ubicación y Referencias

### 1. **Función Backend** (Python)
**Archivo**: `app/funciones/clientes.py`
**Línea**: 307-357
**Función**: `obtener_cliente_por_documento_api(num_documento)`

```python
def obtener_cliente_por_documento_api(num_documento):
    """API para obtener los datos completos de un cliente por su número de documento"""
    # Llama al SP: sp_ObtenerClientePorDocumento
    cursor.execute("CALL sp_ObtenerClientePorDocumento(%s)", (num_documento,))
```

---

### 2. **Ruta Flask** (API Endpoint)
**Archivo**: `app/routes/main.py`
**Línea**: 325-329
**Método**: GET
**Ruta**: `/api/clientes/<num_documento>`

```python
@main_bp.route('/api/clientes/<num_documento>', methods=['GET'])
@login_required
def obtener_cliente(num_documento):
    """API para obtener un cliente por documento"""
    return obtener_cliente_por_documento_api(num_documento)
```

**Protección**: ✅ `@login_required`
**Parámetro**: `num_documento` (Dinámico en URL)
**Retorna**: JSON con datos del cliente o error 404

---

### 3. **Importaciones**
**Ubicaciones donde se importa**:
- `app/routes/main.py` (Línea 41)
- `app/funciones/__init__.py` (Línea 29)

---

## 🔍 ¿Dónde se UTILIZA?

### En Frontend:
❌ **NO se encuentra siendo llamado en el frontend** (clients.html, etc.)

**Posible razón**: Podría estar:
- Reservado para uso futuro
- Usado en API externa
- Usado en scripts internos
- Disponible para desarrollo

### En Backend:
✅ Se importa en:
- `app/routes/main.py` (se registra la ruta)
- `app/funciones/__init__.py` (se exporta)

---

## 📊 Detalles del SP

**Nombre**: `sp_ObtenerClientePorDocumento`
**Parámetros**: `p_num_documento` (VARCHAR 20)
**Retorna**: Un registro (SELECT *) o NULL si no existe

### Estructura esperada:
```
- id_cliente
- num_documento
- num_documento_asesor
- id_fuente_contacto
- id_proyecto
- id_estado_prospeccion
- id_tipo_compra
- prioridad
- fecha_conversion
- monto_conversion
- observaciones
- fecha_creacion
- fecha_actualizacion
- creado_por
- actualizado_por
+ Datos de TblPersona (nombre_completo, email, celular, etc.)
```

---

## 🔗 Endpoint API

### Llamada:
```bash
GET /api/clientes/73017548
Authorization: Bearer TOKEN
```

### Respuesta Exitosa (200):
```json
{
  "success": true,
  "data": {
    "id_cliente": 11,
    "num_documento": "73017548",
    "nombre_completo": "Juan Pérez García",
    "email": "juan@example.com",
    "celular": "999999999",
    "estado_prospeccion": "Activo",
    "prioridad": "Alta",
    "observaciones": "Le interesa el terreno",
    ...
  }
}
```

### Respuesta Error (404):
```json
{
  "success": false,
  "error": "Cliente no encontrado"
}
```

### Respuesta Error (500):
```json
{
  "success": false,
  "error": "Error en la base de datos: ..."
}
```

---

## 💡 CASOS DE USO

### Potencial uso en:

1. **Edición de Cliente** (Modal de edición)
   ```javascript
   fetch('/api/clientes/73017548')
     .then(r => r.json())
     .then(data => {
       // Llenar formulario con datos del cliente
       document.getElementById('nombreInput').value = data.data.nombre_completo;
       // ...
     })
   ```

2. **Detalle de Cliente** (Vista de perfil)
   ```javascript
   const clienteData = await fetch(`/api/clientes/${numDocumento}`);
   // Mostrar información completa del cliente
   ```

3. **Validación de Cliente** (Antes de operación)
   ```javascript
   const cliente = await fetch(`/api/clientes/${numDocumento}`);
   if (cliente.success) {
     // Cliente existe, proceder
   }
   ```

4. **Carga de datos en Modal**
   ```javascript
   function abrirEditarCliente(numDocumento) {
       fetch(`/api/clientes/${numDocumento}`)
         .then(r => r.json())
         .then(data => {
             // Pre-llenar formulario de edición
         })
   }
   ```

---

## ⚠️ ESTADO ACTUAL

### ✅ Implementado:
- SP en BD: `sp_ObtenerClientePorDocumento`
- Función Python: `obtener_cliente_por_documento_api()`
- Ruta Flask: `GET /api/clientes/<num_documento>`
- Protección: Login requerido

### ❌ No se usa en Frontend:
- No hay llamadas JavaScript al endpoint
- No hay modal de edición que use esto
- No hay vista de detalle que use esto

---

## 🎯 RECOMENDACIONES

### Para usar este SP:

1. **Crear Modal de Edición**
   ```html
   <div id="modalEditarCliente">
       <form id="formEditarCliente">
           <input id="nombreInput" />
           <input id="emailInput" />
           <!-- más campos -->
       </form>
   </div>
   ```

2. **Crear Función para Cargar**
   ```javascript
   async function cargarClienteParaEditar(numDocumento) {
       const response = await fetch(`/api/clientes/${numDocumento}`);
       const result = await response.json();
       if (result.success) {
           // Llenar formulario
           document.getElementById('nombreInput').value = 
               result.data.nombre_completo;
       }
   }
   ```

3. **Llamar cuando se abre el modal**
   ```javascript
   // En tabla de clientes, agregar botón "Editar"
   <button onclick="abrirModalEditar('73017548')">Editar</button>
   ```

---

## 📝 RESUMEN

| Aspecto | Detalle |
|--------|---------|
| **SP** | `sp_ObtenerClientePorDocumento(num_documento)` |
| **Función** | `obtener_cliente_por_documento_api()` |
| **Ruta** | `GET /api/clientes/<num_documento>` |
| **Protección** | Login requerido |
| **Parámetro** | `num_documento` |
| **Retorna** | JSON con datos del cliente |
| **En Frontend** | ❌ NO se usa actualmente |
| **Disponible** | ✅ SÍ, lista para usar |
| **Próximo paso** | Implementar modal de edición de cliente |

---

**Versión**: 1.0
**Fecha**: 27 Junio 2026
**Estado**: DISPONIBLE PERO SIN USAR EN FRONTEND
