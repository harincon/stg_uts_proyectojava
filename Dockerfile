# Imagen del Sistema de Gestión de Trabajos de Grado para Render: Tomcat 9 con Java 17.
FROM tomcat:9.0-jdk17-temurin

# Hora de Colombia y UTF-8 para fechas y tildes
ENV TZ=America/Bogota \
    JAVA_OPTS="-Duser.timezone=America/Bogota -Dfile.encoding=UTF-8"

# La aplicación queda en la raíz del sitio (/)
RUN rm -rf /usr/local/tomcat/webapps/*
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

# Render indica el puerto en la variable PORT (si no existe, 8080) y lo busca en 0.0.0.0.
# Se apaga el puerto de apagado (8005) para que el único puerto abierto sea el de la página.
CMD sed -i -e "s/port=\"8005\"/port=\"-1\"/" \
           -e "s/port=\"8080\"/port=\"${PORT:-8080}\" address=\"0.0.0.0\"/" conf/server.xml \
    && exec catalina.sh run
