# Instrucciones para Registrar el SP Ultimos3Seguimientos

## Paso 1: Activar el Túnel SSH
Abre una terminal/CMD y ejecuta:
```bash
ssh -L 3307:127.0.0.1:3306 kallgwkn@162.213.251.186 -p 21098
```
El túnel debe mantenerse activo durante todo el proceso.

## Paso 2: Conectarse a MySQL
En otra terminal, conectate a MySQL:
```bash
mysql -h 127.0.0.1 -P 3307 -u kallgwkn_user -p
```
Contraseña: `#21592159xDxD`

## Paso 3: Seleccionar la Base de Datos
```sql
USE kallgwkn_kallmax_bd;
```

## Paso 4: Ejecutar el Script SQL
Ejecuta el contenido del archivo `sp_Ultimos3Seguimientos.sql`:

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

## Paso 5: Verificar que el SP fue Creado
```sql
SHOW CREATE PROCEDURE sp_Ultimos3Seguimientos;
```

## Paso 6: Probar el SP
```sql
CALL sp_Ultimos3Seguimientos('73017548');
```

## Paso 7: Actualizar en MySQL Workbench (opcional)
Si usas MySQL Workbench:
1. Abre una conexión con SSH tunnel estándar
2. Conecta a: `127.0.0.1:3307`
3. Abre MySQL Workbench Script
4. Pega el contenido de `sp_Ultimos3Seguimientos.sql`
5. Ejecuta (Ctrl+Shift+Enter o Command+Shift+Enter)
6. Verifica en Procedures

## Cambios en la Aplicación Flask

### Archivo: `app/funciones/clientes.py`
- Agregada función: `listar_ultimos_3_seguimientos_api(num_documento)`
- Llamada al SP: `sp_Ultimos3Seguimientos`
- Retorna: Los últimos 3 seguimientos de un cliente

### Archivo: `app/routes/main.py`
- Agregada ruta: `GET /api/ultimos-3-seguimientos/<num_documento>`
- Importada función: `listar_ultimos_3_seguimientos_api`
- Protegida con: `@login_required`

### Archivo: `app/templates/clients.html`
- Actualizada función: `mostrarUltimos3Seguimientos(numDocumento)`
- Ahora llama a: `/api/ultimos-3-seguimientos/{numDocumento}`
- Ya no realiza slice en JavaScript, lo hace directamente el SP

## Resultado Final
Cuando el usuario abre el modal "Registrar Seguimiento":
1. Se carga automáticamente a través del SP `sp_Ultimos3Seguimientos`
2. Se muestran exactamente los 3 últimos seguimientos
3. Cada tarjeta contiene:
   - Tipo de seguimiento
   - Fecha y hora
   - Estado (Pendiente/Completado)
   - Observación
   - Nombre del asesor que realizó el seguimiento

## Diagrama de Flujo
```
Usuario hace clic en ícono de archivo
        ↓
Modal "Registrar Seguimiento" se abre
        ↓
Se llama: mostrarUltimos3Seguimientos(numDocumento)
        ↓
Fetch a: GET /api/ultimos-3-seguimientos/{numDocumento}
        ↓
Flask ejecuta: obtener_ultimos_3_seguimientos()
        ↓
Llama a: listar_ultimos_3_seguimientos_api()
        ↓
MySQL ejecuta: CALL sp_Ultimos3Seguimientos(?)
        ↓
Retorna: Últimos 3 seguimientos (ya limitado por SP)
        ↓
JavaScript renderiza las tarjetas en el modal
```
