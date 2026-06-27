-- SP para obtener los últimos 3 seguimientos de un cliente
-- Creado para el modal "Registrar Seguimiento"

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
