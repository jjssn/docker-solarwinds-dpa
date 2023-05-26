ARG DPA_VERSION=2023.1.0.265
FROM debian:bullseye-slim AS builder
ARG DPA_VERSION
LABEL ProductDownloadName=$PRODUCT_DOWNLOAD_NAME Version=$PRODUCT_DOWNLOAD_DIR ProductName="DPA"
RUN apt-get -qq update && apt-get -qq -y install wget
RUN mkdir -p /usr/src/media \
    && wget -O /usr/src/media/dpa.tar.gz https://downloads.solarwinds.com/solarwinds/Release/DPA/${DPA_VERSION}/SolarWinds-DPA-${DPA_VERSION}-64bit.tar.gz \
    && tar -xvzf /usr/src/media/dpa.tar.gz -C /usr/src/media
FROM debian:bullseye-slim
RUN apt-get -qq update && apt-get -qq install fontconfig \
    && apt-get -qq install procps && mkdir /app \
    && mkdir -p /data/iwc/tomcat
WORKDIR /app
COPY --from=builder /usr/src/media/dpa_*_installer/*.sh .
RUN sh dpa_*_installer.sh -- --silent-install && rm dpa_*_installer.sh
EXPOSE 8123 8124
WORKDIR /app
COPY wrapper_script.sh init.sh ./
RUN chmod +x wrapper_script.sh
CMD ["bash", "wrapper_script.sh"]