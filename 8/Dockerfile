FROM alpine:3.12.0

LABEL maintainer="应卓 <yingzhor@gmail.com>"

RUN addgroup -g 1001 -S spring && \
    adduser  -u 1001 -S spring -G spring && \
    apk add --update bash ca-certificates openjdk8-jre font-adobe-100dpi ttf-dejavu fontconfig && \
    wget "https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64" -O /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    mkdir -p /var/log/ && chown spring:spring /var/log && \
    mkdir -p /var/data/ && chown spring:spring /var/data && \
    mkdir -p /home/spring/log/ && chown spring:spring /home/spring/log/ && \
    mkdir -p /home/spring/data/ && chown spring:spring /home/spring/data/ && \
    mkdir -p /home/spring/config/ && chown spring:spring /home/spring/config/ && \
    mkdir -p /home/spring/tmp/ && chown spring:spring /home/spring/tmp/ && \
    rm -rf /var/cache/apk/* && \
    rm -rf "$JAVA_HOME/man/" && \
    rm -rf "$JAVA_HOME/demo/" && \
    rm -rf "$JAVA_HOME/release" && \
    rm -rf "$JAVA_HOME/THIRD_PARTY_README" && \
    rm -rf "$JAVA_HOME/ASSEMBLY_EXCEPTION" && \
    rm -rf "$JAVA_HOME/LICENSE" && \
    rm -rf "$JAVA_HOME/README" && \
    rm -rf "$JAVA_HOME/jre/ASSEMBLY_EXCEPTION" && \
    rm -rf "$JAVA_HOME/jre/LICENSE" && \
    rm -rf "$JAVA_HOME/jre/THIRD_PARTY_README" && \
    rm -rf "$JAVA_HOME/lib/missioncontrol" && \
    rm -rf "$JAVA_HOME/lib/visualvm" && \
    rm -rf "$JAVA_HOME/lib/*javafx*" && \
    rm -rf "$JAVA_HOME/jre/lib/plugin.jar" && \
    rm -rf "$JAVA_HOME/jre/lib/ext/jfxrt.jar" && \
    rm -rf "$JAVA_HOME/jre/bin/javaws" && \
    rm -rf "$JAVA_HOME/jre/lib/javaws.jar" && \
    rm -rf "$JAVA_HOME/jre/lib/desktop" && \
    rm -rf "$JAVA_HOME/jre/plugin" && \
    rm -rf "$JAVA_HOME/jre/lib/deploy*" && \
    rm -rf "$JAVA_HOME/jre/lib/*javafx*" && \
    rm -rf "$JAVA_HOME/jre/lib/*jfx*" && \
    rm -rf "$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" && \
    rm -rf "$JAVA_HOME/jre/lib/amd64/libprism_*.so" && \
    rm -rf "$JAVA_HOME/jre/lib/amd64/libfxplugins.so" && \
    rm -rf "$JAVA_HOME/jre/lib/amd64/libglass.so" && \
    rm -rf "$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" && \
    rm -rf "$JAVA_HOME/jre/lib/amd64/libjavafx*.so" && \
    rm -rf "$JAVA_HOME/jre/lib/amd64/libjfx*.so"

COPY ./docker-entrypoint.sh /home/spring/docker-entrypoint.sh

RUN chmod +x /home/spring/docker-entrypoint.sh

WORKDIR /home/spring

USER root:root

ENTRYPOINT ["/home/spring/docker-entrypoint.sh"]