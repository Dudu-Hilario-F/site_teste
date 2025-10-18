# 1️⃣ Usa uma imagem leve do Nginx
FROM nginx:alpine

# 2️⃣ Instala ferramentas úteis para debugging (opcional)
RUN apk add --no-cache curl bash vim

# 3️⃣ Cria diretório para configuração personalizada do Nginx
RUN mkdir -p /etc/nginx/conf.d

# 4️⃣ Copia configuração personalizada do Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 5️⃣ Copia os arquivos do site para o diretório padrão do Nginx
COPY *.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/

# 6️⃣ Define variáveis de ambiente para configuração
ENV NGINX_HOST=localhost
ENV NGINX_PORT=80

# 7️⃣ Expõe a porta padrão do Nginx
EXPOSE 80

# 8️⃣ Healthcheck para verificar se o Nginx está funcionando
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost/ || exit 1

# 9️⃣ Comando padrão do container
CMD ["nginx", "-g", "daemon off;"]
