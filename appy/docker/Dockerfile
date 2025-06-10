FROM host.docker.internal:5000/basejava

ENV JAVA_OPTS=""4
ENV JAVA_RELEASE=21
ENV TZ=Europe/Prague

WORKDIR /opt/app
VOLUME /tmp
COPY layers/dependencies/ ./
COPY layers/spring-boot-loader/ ./
COPY layers/snapshot-dependencies/ ./
COPY layers/application/ ./

ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
