# Use a imagem Node.js como base
FROM node:20.18

# Defina o diretório de trabalho
WORKDIR /app

# Copie os arquivos de configuração e o package.json do frontend
COPY package*.json ./

# Instale as dependências
RUN npm install

# Copie o restante do código do frontend
COPY . .

# Build do frontend
RUN npm run build

# Instale o servidor estático 'serve' globalmente
RUN npm install -g serve

# Exponha a porta
EXPOSE 3010

# Comando para iniciar o servidor
CMD ["serve", "-s", "build", "-l", "3010"]