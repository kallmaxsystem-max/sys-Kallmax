-- Actualizar SP para incluir JOINs correctos con tablas de ubicación
-- Los campos de ubicación se obtienen desde TblPersona -> TblDistritos -> TblProvincias -> TblDepartamentos

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_ObtenerClientePorDocumento$$

CREATE PROCEDURE sp_ObtenerClientePorDocumento(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        -- Datos de TblClientes
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
        -- Datos de TblPersona
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
        -- IDs y nombres de ubicación
        p.id_distrito,
        d.nombre AS distrito,
        d.id_provincia,
        pr.nombre AS provincia,
        pr.id_departamento,
        dep.nombre AS departamento,
        -- Estado Prospeccion
        ep.nombre AS estado_prospeccion
    FROM TblClientes c
    INNER JOIN TblPersona p ON c.num_documento = p.num_documento
    LEFT JOIN TblDistritos d ON p.id_distrito = d.id_distrito
    LEFT JOIN TblProvincias pr ON d.id_provincia = pr.id_provincia
    LEFT JOIN TblDepartamentos dep ON pr.id_departamento = dep.id_departamento
    INNER JOIN TblEstadoProspeccion ep ON c.id_estado_prospeccion = ep.id_estado_prospeccion
    WHERE c.num_documento = p_num_documento;
END$$

DELIMITER ;

-- Probar el SP actualizado
CALL sp_ObtenerClientePorDocumento('73017548');
