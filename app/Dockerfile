FROM nginx:alpine

# Kopiujemy naszą aplikację do katalogu serwera Nginx
COPY index.html /usr/share/nginx/html/index.html

# Cybersec Hardening: Zmiana uprawnień, aby Nginx mógł działać bez roota
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d

RUN touch /var/run/nginx.pid && chown -R nginx:nginx /var/run/nginx.pid

# Przełączamy kontener na bezpiecznego użytkownika nieuprzywilejowanego
USER nginx

EXPOSE 80