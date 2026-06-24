@echo off
echo ===================================
echo Probando configuracion Railway localmente
echo ===================================
echo.

REM Configurar variables de entorno para prueba
set PORT=5000
set SECRET_KEY=test-secret-key-local
set RAILWAY_ENVIRONMENT=local

echo Instalando dependencias...
pip install -r requirements.txt

echo.
echo Iniciando servidor con gunicorn...
echo Accede a: http://localhost:5000
echo.
echo Presiona Ctrl+C para detener
echo.

gunicorn main:app --bind 0.0.0.0:%PORT% --workers 2 --reload
