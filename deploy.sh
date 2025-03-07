#!/bin/bash

# Verifica si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Error: Docker no está instalado."
    exit 1
fi

# Construye la imagen
docker build -t node-app .

# Verifica si la imagen se construyó correctamente
if [ $? -ne 0 ]; then
    echo "Error: Falló la construcción de la imagen."
    exit 1
fi

# Detiene y elimina contenedores previos
docker stop node-container 2>/dev/null
docker rm node-container 2>/dev/null

# Ejecuta el contenedor con variables de entorno
docker run -d -p 8080:8080 --name node-container -e PORT=8080 -e NODE_ENV=production node-app

# Espera unos segundos para que el servicio inicie
sleep 3

# Realiza una prueba de conectividad
if curl -s http://localhost:8080/health; then
    echo -e "\nLa aplicación está funcionando correctamente."
else
    echo "Error: La aplicación no responde."
    exit 1
fi
