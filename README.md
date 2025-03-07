# ArquitecturaSFV-P1

# Evaluación Práctica - Ingeniería de Software V

## Información del Estudiante

- **Nombre:** Esteban Gaviria Zambrano
- **Código:** A00396019
- **Fecha:** 7 de Marzo de 2025

## Resumen de la Solución

Esta solución implementa una aplicación Node.js contenerizada utilizando Docker. Además, se automatiza el proceso de construcción, despliegue y prueba del contenedor mediante un script en Bash. La solución sigue principios DevOps clave, como la automatización, infraestructura como código y observabilidad.

## Dockerfile

1. **Elección de la imagen base** (`FROM node:20-alpine`)
   - Se usa `node:20-alpine`, una versión ligera y optimizada de Node.js, reduciendo el tamaño de la imagen y mejorando el rendimiento.
2. **Definición del directorio de trabajo** (`WORKDIR /app`)
   - Se establece `/app` como directorio base para mantener el entorno de ejecución ordenado.
3. **Copia de archivos esenciales** (`COPY package.json ./` y `COPY app.js ./`)
   - Se copian solo los archivos necesarios (`package.json` y `app.js`), evitando transferir archivos innecesarios.
4. **Instalación de dependencias** (`RUN npm install --omit=dev`)
   - Se instala solo las dependencias de producción (`--omit=dev`), reduciendo el tamaño de la imagen y mejorando la seguridad.
5. **Exposición del puerto de la aplicación** (`EXPOSE 3000`)
   - Se indica que el contenedor usará el puerto `3000`, facilitando la configuración de redes.
6. **Definición del comando de inicio** (`CMD ["node", "app.js"]`)
   - Se usa `CMD` para iniciar la aplicación con `node app.js`, permitiendo flexibilidad si se quiere sobrescribir en tiempo de ejecución.

---

El contenedor puede probarse fácilmente utilizando los siguientes comandos:

1. **Construir la imagen**:

   ```bash
   docker build -t node-app .
   ```

2. **Ejecutar el contenedor**:

   ```bash
   docker run -d -p 8080:3000 node-app
   ```

3. **Verificar que la aplicación está funcionando**:
   ```bash
   curl http://localhost:8080/health
   ```

---

## Script de Automatización

El script automatiza el proceso de construcción y despliegue de una aplicación en un contenedor Docker, asegurando que se ejecute correctamente.

### **Funcionalidades implementadas:**

1. **Verifica si Docker está instalado** (`command -v docker`) y finaliza con error si no lo está.
2. **Construye la imagen Docker** (`docker build -t node-app .`).
3. **Valida la construcción de la imagen** (`$? -ne 0`) y detiene la ejecución en caso de error.
4. **Detiene y elimina contenedores previos** (`docker stop` y `docker rm` silenciosamente).
5. **Ejecuta un nuevo contenedor** (`docker run -d -p 8080:8080 --name node-container -e PORT=8080 -e NODE_ENV=production node-app`).
6. **Espera 3 segundos** (`sleep 3`) para dar tiempo al servicio a iniciar.
7. **Realiza una prueba de conectividad** con `curl` a `http://localhost:8080/health` para verificar que el servicio responde correctamente.
8. **Muestra un mensaje de éxito o error** según la respuesta del servidor.

## Principios DevOps Aplicados

1. **Automatización**

   - Se implementó un **script Bash** (`deploy.sh`) para automatizar tareas como la construcción de la imagen Docker, el despliegue del contenedor y la verificación del servicio.
   - **Beneficio**: Reduce la intervención manual, minimiza errores humanos y garantiza un proceso repetible y eficiente en cualquier entorno.

2. **Infraestructura como Código (IaC)**

   - Se utilizó **Docker** para definir el entorno de ejecución de la aplicación mediante un `Dockerfile`.
   - **Beneficio**: Asegura que el entorno sea consistente en cualquier máquina o servidor, eliminando el problema clásico de "funciona en mi máquina" y facilitando la portabilidad.

3. **Observabilidad y Monitorización**
   - Se incluyó una prueba automática con `curl` en el script de despliegue para verificar que el servicio responde correctamente en el endpoint `/health`.
   - **Beneficio**: Permite detectar fallos rápidamente después del despliegue y garantiza que la aplicación esté operativa antes de considerarla exitosa.

## Captura de Pantalla

![Prueba del contenedor en Docker](/images/evidence-1.png)
![Evidencia 1 de la aplicación en ejecución](/images/evidence-2.png)
![Evidencia 2 de la aplicación en ejecución](/images/evidence-3.png)

## Mejoras Futuras

1. **Uso de un archivo de configuración**: Actualmente, las variables de entorno (`PORT`, `NODE_ENV`) se definen manualmente. Se podría usar un archivo `.env` y `dotenv` en Node.js para mejorar la gestión de configuración.
2. **Orquestación con Docker Compose**: Para facilitar el despliegue en entornos más complejos con múltiples servicios, se podría crear un `docker-compose.yml`.
3. **Implementación de CI/CD**: Integrar el proyecto con GitHub Actions o Jenkins para automatizar la construcción y despliegue del contenedor en un servidor o cloud.

## Instrucciones para Ejecutar

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/EstebanGZam/ArquitecturaSFV-P1.git
   cd ArquitecturaSFV-P1
   ```
2. **Ejecutar el script de automatización**:
   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```
3. **Verificar que la aplicación está funcionando**:
   ```bash
   curl http://localhost:8080
   ```
