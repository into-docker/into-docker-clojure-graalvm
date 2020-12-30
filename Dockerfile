FROM clojure:lein-2.9.5 AS lein
FROM oracle/graalvm-ce:20.3.0-java11 AS graalvm

ARG USER="builder"

LABEL maintainer="Yannick Scherer <yannick.scherer@gmail.com>"
LABEL org.opencontainers.image.authors="Yannick Scherer <yannick.scherer@gmail.com>"
LABEL org.opencontainers.image.licenses="MIT"

LABEL org.into-docker.builder-user="${USER}"
LABEL org.into-docker.runner-image="busybox:glibc"
LABEL org.into-docker.runner-entrypoint="/opt/app/run"

# Native Image
ENV GRAALVM_HOME=$JAVA_HOME
RUN gu install native-image

# Leiningen
COPY --from=lein /usr/local/bin/lein /usr/local/bin/lein
COPY --from=lein /root/.lein /root/.lein
COPY --from=lein /root/.m2 /root/.m2
COPY --from=lein /usr/share/java/leiningen-2.9.5-standalone.jar \
                 /usr/share/java/leiningen-2.9.5-standalone.jar

WORKDIR /into
ENV HOME="/into/home" LEIN_JVM_OPTS="-Duser.home=/into/home"
RUN useradd -d "${HOME}" -m "${USER}"
COPY into/ .
