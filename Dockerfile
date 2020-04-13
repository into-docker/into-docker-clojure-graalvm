FROM clojure:lein-2.9.1 AS lein
FROM oracle/graalvm-ce:20.0.0-java11 AS graalvm

ARG COMMIT
ARG BUILD_DATE

LABEL maintainer="Yannick Scherer <yannick.scherer@gmail.com>"
LABEL org.opencontainers.image.authors="Yannick Scherer <yannick.scherer@gmail.com>"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/into-docker/into-docker-clojure-graalvm"
LABEL org.opencontainers.image.url="https://github.com/into-docker/into-docker-clojure-graalvm"
LABEL org.opencontainers.image.revision="${COMMIT}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"

LABEL org.into-docker.runner-image="busybox:glibc"
LABEL org.into-docker.runner-cmd="/opt/app/run"

# Native Image
ENV GRAALVM_HOME=$JAVA_HOME
RUN gu install native-image

# Leiningen
COPY --from=lein /usr/local/bin/lein /usr/local/bin/lein
COPY --from=lein /root/.lein /root/.lein
COPY --from=lein /root/.m2 /root/.m2
COPY --from=lein /usr/share/java/leiningen-2.9.1-standalone.jar \
                 /usr/share/java/leiningen-2.9.1-standalone.jar

WORKDIR /into

# Add ignore information from Github's collection of ignore files
# License: CC0 1.0 Universal
RUN curl -sL "https://raw.githubusercontent.com/github/gitignore/master/LICENSE" > ignore.LICENSE && \
    curl -sL "https://raw.githubusercontent.com/github/gitignore/master/Leiningen.gitignore" > ignore

COPY into/ .
