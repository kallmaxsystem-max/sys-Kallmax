@echo off
REM KallMax - Script de Inicio
echo.
echo ====================================================================
echo.
echo                 🚀 KALLMAX - Iniciando Sistema
echo.
echo ====================================================================
echo.

REM Verificar Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python no está instalado
    pause
    exit /b 1
)

REM Instalar dependencias
echo 📦 Verificando dependencias...
pip install -q -r requirements.txt

REM Iniciar servidor
echo.
echo 🚀 Iniciando servidor Flask...
echo.
echo ✅ Servidor corriendo en:
echo    - Local:  http://127.0.0.1:5000
echo    - Red:    http://192.168.18.34:5000
echo.
echo 💡 Presiona Ctrl+C para detener el servidor
echo.

REM Esperar 2 segundos y abrir navegador
timeout /t 2 /nobreak >nul
start http://127.0.0.1:5000

REM Iniciar Flask
python main.py
