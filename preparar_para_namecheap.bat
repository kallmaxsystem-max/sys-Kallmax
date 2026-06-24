@echo off
echo ============================================
echo PREPARAR ARCHIVOS PARA NAMECHEAP
echo ============================================
echo.

echo Este script ayudara a preparar tus archivos para subir a Namecheap
echo.

REM Crear carpeta temporal
if exist namecheap_deploy rmdir /s /q namecheap_deploy
mkdir namecheap_deploy

echo [1/6] Copiando archivos principales...
copy passenger_wsgi.py namecheap_deploy\
copy app.py namecheap_deploy\
copy main.py namecheap_deploy\
copy requirements.txt namecheap_deploy\
copy .env.example namecheap_deploy\.env

echo [2/6] Copiando carpeta app...
xcopy /E /I /Y app namecheap_deploy\app

echo [3/6] Limpiando archivos innecesarios...
del /S /Q namecheap_deploy\__pycache__\* 2>nul
rmdir /S /Q namecheap_deploy\__pycache__ 2>nul
del /S /Q namecheap_deploy\app\__pycache__\* 2>nul
rmdir /S /Q namecheap_deploy\app\__pycache__ 2>nul
del /S /Q namecheap_deploy\app\routes\__pycache__\* 2>nul
rmdir /S /Q namecheap_deploy\app\routes\__pycache__ 2>nul

echo [4/6] Creando archivo de instrucciones...
echo INSTRUCCIONES RAPIDAS > namecheap_deploy\LEEME.txt
echo. >> namecheap_deploy\LEEME.txt
echo 1. Sube todos estos archivos a public_html en cPanel >> namecheap_deploy\LEEME.txt
echo 2. En cPanel, ve a "Setup Python App" >> namecheap_deploy\LEEME.txt
echo 3. Crea una aplicacion Python 3.11 >> namecheap_deploy\LEEME.txt
echo 4. Application startup file: passenger_wsgi.py >> namecheap_deploy\LEEME.txt
echo 5. Entry point: application >> namecheap_deploy\LEEME.txt
echo 6. En SSH/Terminal: >> namecheap_deploy\LEEME.txt
echo    cd ~/public_html >> namecheap_deploy\LEEME.txt
echo    source ~/virtualenv/.../bin/activate >> namecheap_deploy\LEEME.txt
echo    pip install -r requirements.txt >> namecheap_deploy\LEEME.txt
echo 7. Edita .env con tu SECRET_KEY >> namecheap_deploy\LEEME.txt
echo 8. Reinicia la app en cPanel >> namecheap_deploy\LEEME.txt
echo. >> namecheap_deploy\LEEME.txt
echo Para mas detalles, lee GUIA_SUBIR_NAMECHEAP.md >> namecheap_deploy\LEEME.txt

echo [5/6] Creando archivo ZIP...
powershell Compress-Archive -Path namecheap_deploy\* -DestinationPath kallmax-namecheap.zip -Force

echo [6/6] Limpiando...
REM Mantener la carpeta para referencia
REM rmdir /s /q namecheap_deploy

echo.
echo ============================================
echo COMPLETADO!
echo ============================================
echo.
echo Se ha creado: kallmax-namecheap.zip
echo.
echo PROXIMOS PASOS:
echo 1. Sube kallmax-namecheap.zip a cPanel File Manager
echo 2. Extrae el ZIP en public_html
echo 3. Sigue las instrucciones en GUIA_SUBIR_NAMECHEAP.md
echo.
echo Los archivos tambien estan en la carpeta: namecheap_deploy\
echo.
pause
