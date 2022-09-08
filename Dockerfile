ARG OATHKEEPER_IMAGE_TAG=v0.39.4

FROM oryd/oathkeeper:$OATHKEEPER_IMAGE_TAG

USER root

WORKDIR /app

COPY ./autho/start.sh ./start.sh
RUN chmod +x ./start.sh

COPY ./autho/conf/ ./conf/

ENV AUTHO_PORT=24000 \
    AUTHO_AUTHE_URL=https://localhost:23000 \
    AUTHO_AUTHGATE_PUBLIC_URL=https://localhost:21000

EXPOSE 24000

ENTRYPOINT ["./start.sh"]
CMD []
