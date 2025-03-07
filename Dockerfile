# Usa una imagen base de Node.js
FROM node:20-alpine

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos necesarios
COPY package.json ./
COPY app.js ./

# Instala las dependencias
RUN npm install --omit=dev

# Expone el puerto de la aplicación
EXPOSE 3000

# Define el comando para ejecutar la aplicación
CMD ["node", "app.js"]
