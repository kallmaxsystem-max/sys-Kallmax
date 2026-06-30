-- Verificar qué retorna actualmente el SP
CALL sp_ObtenerClientePorDocumento('73017548');

-- Si el SP no tiene fecha_nacimiento e id_estado_prospeccion, ejecutar esto:

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_ObtenerClientePorDocumento$$

CREATE PROCEDURE sp_ObtenerClientePorDocumento(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        c.id_cliente,
        c.num_documento,
        c.num_documento_asesor,
        c.id_fuente_contacto,
        c.id_proyecto,
        c.id_estado_prospeccion,
        c.id_tipo_compra,
        c.prioridad,
        c.fecha_conversion,
        c.monto_conversion,
        c.observaciones,
        c.fecha_creacion,
        c.fecha_actualizacion,
        c.creado_por,
        c.actualizado_por,
        p.tipo_documento,
        p.genero,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        p.fecha_nacimiento,
        p.estado_civil,
        p.email,
        p.celular,
        p.direccion,
        p.id_departamento,
        p.id_provincia,
        p.id_distrito,
        ep.nombre AS estado_prospeccion
    FROM TblClientes c
    INNER JOIN TblPersona p ON c.num_documento = p.num_documento
    LEFT JOIN TblEstadoProspeccion ep ON c.id_estado_prospeccion = ep.id_estado_prospeccion
    WHERE c.num_documento = p_num_documento;
END$$

DELIMITER ;

-- Probar el SP actualizado
CALL sp_ObtenerClientePorDocumento('73017548');
