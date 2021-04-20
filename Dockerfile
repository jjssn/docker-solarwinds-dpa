FROM debian:bullseye-slim AS builder
ENV PRODUCT_DOWNLOAD_DIR=2021.1.872 PRODUCT_DOWNLOAD_NAME=SolarWinds-DPA-2021.1.872-64bit.tar.gz
LABEL ProductDownloadName=$PRODUCT_DOWNLOAD_NAME Version=$PRODUCT_DOWNLOAD_DIR ProductName="DPA"
RUN apt-get -qq update && apt-get -qq -y install wget
RUN mkdir -p /usr/src/media \
    && wget -O /usr/src/media/dpa.tar.gz https://downloads.solarwinds.com/solarwinds/Release/DatabasePeformanceAnalyzer-DPA/$PRODUCT_DOWNLOAD_DIR/$PRODUCT_DOWNLOAD_NAME \
    && tar -xvzf /usr/src/media/dpa.tar.gz -C /usr/src/media

FROM debian:bullseye-slim
ENV PRODUCT_DOWNLOAD_DIR=2021_1_872
RUN apt-get -qq update && apt-get -qq install fontconfig \
    && apt-get -qq install procps && mkdir /app \
    && mkdir -p /data/iwc/tomcat
WORKDIR /app
COPY --from=builder /usr/src/media/dpa_*_installer/*.sh .
RUN sh dpa_*_installer.sh -- --silent-install && rm dpa_*_installer.sh
EXPOSE 8123 8124
WORKDIR /app/dpa_$PRODUCT_DOWNLOAD_DIR
COPY ./init.sh .
RUN chmod +x init.sh && ./init.sh
COPY ./wrapper_script.sh .
CMD ./wrapper_script.sh
