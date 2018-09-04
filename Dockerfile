FROM afalko/alpine-java:4

LABEL version="0.1"

MAINTAINER dvastrata@salesforce.com

ADD dockerfile-image-update-cmdtool/target/dockerfile-image-update.jar /

ENTRYPOINT ["java", "-jar", "/dockerfile-image-update.jar"]
