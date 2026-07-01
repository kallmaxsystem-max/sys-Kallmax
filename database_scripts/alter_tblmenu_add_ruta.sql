-- Script para agregar campo 'ruta' a TblMenu
-- Ejecutar en la base de datos de producción

-- Verificar si la columna ya existe
ALTER TABLE TblMenu 
ADD COLUMN ruta VARCHAR(255) NULL DEFAULT NULL 
AFTER nombre_menu;

-- Agregar comentario a la columna
ALTER TABLE TblMenu MODIFY COLUMN ruta VARCHAR(255) COMMENT 'Ruta o URL del menú principal';

-- Verificar la estructura
DESCRIBE TblMenu;
