#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Módulo de funciones de negocio para KallMax
Contiene lógica de negocio separada de las rutas
"""

from .register_user import (
    get_departamentos,
    get_provincias,
    get_distritos,
    get_roles,
    get_areas,
    get_cargos,
    register_asesor_api,
    get_usuarios_asesores,
    get_asesor_by_documento,
    update_asesor_api,
    delete_asesor_api,
    cambiar_contrasena_api,
    get_fuentes_contacto_api,
    get_proyectos_api,
    get_estados_prospeccion_api,
    get_tipos_compra_api,
    insertar_cliente_api,
    listar_clientes_api,
    listar_todos_clientes_api
)

__all__ = [
    'get_departamentos',
    'get_provincias',
    'get_distritos',
    'get_roles',
    'get_areas',
    'get_cargos',
    'register_asesor_api',
    'get_usuarios_asesores',
    'get_asesor_by_documento',
    'update_asesor_api',
    'delete_asesor_api',
    'cambiar_contrasena_api',
    'get_fuentes_contacto_api',
    'get_proyectos_api',
    'get_estados_prospeccion_api',
    'get_tipos_compra_api',
    'insertar_cliente_api',
    'listar_clientes_api',
    'listar_todos_clientes_api'
]
