#!/usr/bin/env python3
"""
Script para generar SECRET_KEY segura para Flask
"""
import secrets

print("=" * 60)
print("GENERADOR DE SECRET_KEY PARA FLASK")
print("=" * 60)
print()

# Generar clave hexadecimal (recomendado)
secret_key_hex = secrets.token_hex(32)
print("Opción 1 - Hexadecimal (64 caracteres):")
print(f"SECRET_KEY={secret_key_hex}")
print()

# Generar clave URL-safe
secret_key_urlsafe = secrets.token_urlsafe(32)
print("Opción 2 - URL-safe (más compacta):")
print(f"SECRET_KEY={secret_key_urlsafe}")
print()

print("=" * 60)
print("INSTRUCCIONES:")
print("=" * 60)
print("1. Copia UNA de las claves generadas arriba")
print("2. Ve a tu proyecto en Railway Dashboard")
print("3. Ve a Variables > + New Variable")
print("4. Nombre: SECRET_KEY")
print("5. Valor: [pega la clave copiada]")
print("6. Click en 'Add' y Railway redesplegará automáticamente")
print()
print("⚠️  IMPORTANTE: No compartas esta clave en Git o públicamente")
print("=" * 60)
