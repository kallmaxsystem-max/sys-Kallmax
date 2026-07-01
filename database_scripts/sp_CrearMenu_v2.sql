-- SP Actualizado: sp_CrearMenu con soporte para campo 'ruta'
-- Reemplazar el SP existente

DELIMITER //

DROP PROCEDURE IF EXISTS sp_CrearMenu //

CREATE PROCEDURE sp_CrearMenu(
    IN p_nombre_menu VARCHAR(100),
    IN p_descripcion VARCHAR(255),
    IN p_ruta VARCHAR(255),
    IN p_estado VARCHAR(20)
)
BEGIN
    DECLARE v_error_message VARCHAR(255);
    
    -- Validar que el nombre_menu no esté vacío
    IF p_nombre_menu IS NULL OR p_nombre_menu = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del menú no puede estar vacío';
    END IF;
    
    -- Validar que el estado sea válido
    IF p_estado NOT IN ('Activo', 'Inactivo') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estado debe ser Activo o Inactivo';
    END IF;
    
    -- Validar que no exista un menú con el mismo nombre
    IF EXISTS (SELECT 1 FROM TblMenu WHERE nombre_menu = p_nombre_menu) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe un menú con ese nombre';
    END IF;
    
    -- Insertar el nuevo menú
    INSERT INTO TblMenu (nombre_menu, descripcion, ruta, estado, fecha_creacion)
    VALUES (p_nombre_menu, p_descripcion, p_ruta, p_estado, NOW());
    
END //

DELIMITER ;

-- Verificar que el SP se creó correctamente
SHOW PROCEDURE STATUS WHERE Name = 'sp_CrearMenu';
