FROM wordpress:latest

# MAX FILE UPLOADS
COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Permisos del volumen montado
RUN groupadd --gid 1010 myguest
RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

ENV MY_USER=myguest

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

# EXPOSE 22
# ENTRYPOINT ["/sbin/entrypoint.sh"]