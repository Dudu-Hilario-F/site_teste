# 1️⃣ Usa uma imagem leve do Nginx
FROM nginx:alpine

# 2️⃣ Instala ferramentas úteis para debugging (opcional)
RUN apk add --no-cache curl bash vim

# 3️⃣ Cria diretório para configuração personalizada do Nginx
RUN mkdir -p /etc/nginx/conf.d

# 4️⃣ Copia configuração personalizada do Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 5️⃣ Copia os arquivos do site para o diretório padrão do Nginx
COPY . /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/

# 6️⃣ Define variáveis de ambiente para configuração
ENV NGINX_HOST=192.168.1.11
ENV NGINX_PORT=8080

# 7️⃣ Expõe a porta configurada do Nginx
EXPOSE 8080

# 8️⃣ Healthcheck para verificar se o Nginx está funcionando
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://192.168.1.11:8080/ || exit 1

# 9️⃣ Comando padrão do container
CMD ["nginx", "-g", "daemon off;"]
