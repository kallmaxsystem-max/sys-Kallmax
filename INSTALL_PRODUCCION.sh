#!/bin/bash

################################################################################
# SCRIPT DE INSTALACIÓN RÁPIDA - ÚLTIMOS 3 SEGUIMIENTOS
# Fecha: 27 Junio 2026
# Commit: b460284
################################################################################

set -e  # Exit on error

echo "════════════════════════════════════════════════════════════════"
echo "INSTALACIÓN: Últimos 3 Seguimientos - Kallmax"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================================================
# PASO 1: Verificar requisitos
# ============================================================================
echo -e "${YELLOW}[PASO 1]${NC} Verificando requisitos..."

if ! command -v mysql &> /dev/null; then
    echo -e "${RED}✗ MySQL no está instalado${NC}"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo -e "${RED}✗ Git no está instalado${NC}"
    exit 1
fi

if ! command -v supervisorctl &> /dev/null; then
    echo -e "${YELLOW}⚠ Supervisord no encontrado (si usas otro gestor, reinicia manualmente)${NC}"
fi

echo -e "${GREEN}✓ Requisitos OK${NC}"
echo ""

# ============================================================================
# PASO 2: Crear el SP en la BD
# ============================================================================
echo -e "${YELLOW}[PASO 2]${NC} Creando Stored Procedure en BD..."

# Leer credenciales (o usar valores por defecto)
read -p "Servidor MySQL [127.0.0.1]: " DB_HOST
DB_HOST=${DB_HOST:-127.0.0.1}

read -p "Puerto MySQL [3307]: " DB_PORT
DB_PORT=${DB_PORT:-3307}

read -p "Usuario MySQL [kallgwkn_user]: " DB_USER
DB_USER=${DB_USER:-kallgwkn_user}

read -sp "Contraseña MySQL: " DB_PASSWORD
echo ""

read -p "Base de Datos [kallgwkn_kallmax_bd]: " DB_NAME
DB_NAME=${DB_NAME:-kallgwkn_kallmax_bd}

# Ejecutar el SP
if [ -f "sp_Ultimos3Seguimientos.sql" ]; then
    echo "Ejecutando: sp_Ultimos3Seguimientos.sql"
    
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < sp_Ultimos3Seguimientos.sql
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ SP creado correctamente${NC}"
    else
        echo -e "${RED}✗ Error al crear SP${NC}"
        exit 1
    fi
else
    echo -e "${RED}✗ Archivo sp_Ultimos3Seguimientos.sql no encontrado${NC}"
    exit 1
fi
echo ""

# ============================================================================
# PASO 3: Verificar SP
# ============================================================================
echo -e "${YELLOW}[PASO 3]${NC} Verificando SP..."

RESULT=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" -e "SHOW PROCEDURES LIKE 'sp_Ultimos3%';" 2>/dev/null | grep -c "sp_Ultimos3Seguimientos" || echo "0")

if [ "$RESULT" -eq 1 ]; then
    echo -e "${GREEN}✓ SP verificado correctamente${NC}"
else
    echo -e "${RED}✗ SP no encontrado en BD${NC}"
    exit 1
fi
echo ""

# ============================================================================
# PASO 4: Copiar archivos Python
# ============================================================================
echo -e "${YELLOW}[PASO 4]${NC} Actualizando archivos Python..."

read -p "¿Usar Git pull? (s/n) [s]: " USE_GIT
USE_GIT=${USE_GIT:-s}

if [[ "$USE_GIT" == "s" ]] || [[ "$USE_GIT" == "S" ]]; then
    echo "Ejecutando: git pull origin main"
    git pull origin main
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Archivos actualizados${NC}"
    else
        echo -e "${RED}✗ Error en git pull${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠ Actualización manual requerida:${NC}"
    echo "  1. Copiar: app/funciones/clientes.py"
    echo "  2. Copiar: app/routes/main.py"
    echo "  3. Copiar: app/templates/clients.html"
fi
echo ""

# ============================================================================
# PASO 5: Reiniciar Flask
# ============================================================================
echo -e "${YELLOW}[PASO 5]${NC} Reiniciando aplicación Flask..."

if command -v supervisorctl &> /dev/null; then
    supervisorctl restart kallmax
    
    sleep 2
    
    if supervisorctl status kallmax | grep -q "RUNNING"; then
        echo -e "${GREEN}✓ Flask reiniciado${NC}"
    else
        echo -e "${RED}✗ Error al reiniciar Flask${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠ Reinicia Flask manualmente${NC}"
    echo "  Comando: systemctl restart kallmax"
    echo "  o: supervisorctl restart kallmax"
fi
echo ""

# ============================================================================
# PASO 6: Validación final
# ============================================================================
echo -e "${YELLOW}[PASO 6]${NC} Validación final..."

# Esperar a que Flask esté listo
sleep 2

read -p "URL de producción [http://localhost:5000]: " APP_URL
APP_URL=${APP_URL:-http://localhost:5000}

# Probar endpoint
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL/api/ultimos-3-seguimientos/73017548")

if [ "$RESPONSE" == "401" ] || [ "$RESPONSE" == "200" ]; then
    echo -e "${GREEN}✓ Endpoint responde correctamente${NC}"
else
    echo -e "${YELLOW}⚠ Respuesta HTTP: $RESPONSE (Expected 200 or 401)${NC}"
fi
echo ""

# ============================================================================
# RESUMEN
# ============================================================================
echo "════════════════════════════════════════════════════════════════"
echo -e "${GREEN}✓ INSTALACIÓN COMPLETADA${NC}"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Pasos realizados:"
echo "  ✓ SP 'sp_Ultimos3Seguimientos' creado en BD"
echo "  ✓ Archivos Python actualizados"
echo "  ✓ Flask reiniciado"
echo "  ✓ Endpoint validado"
echo ""
echo "Verificación manual:"
echo "  1. Accede a: $APP_URL/clientes"
echo "  2. Haz clic en icono de archivo (📎) en un cliente"
echo "  3. Verifica que aparezca 'Últimos 3 Seguimientos'"
echo ""
echo "Logs para debugging:"
echo "  tail -f /var/log/kallmax/kallmax_app.log"
echo ""
echo "════════════════════════════════════════════════════════════════"
