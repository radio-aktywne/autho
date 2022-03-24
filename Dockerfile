ARG OATHKEEPER_IMAGE_TAG=v0.38.23

FROM oryd/oathkeeper:$OATHKEEPER_IMAGE_TAG

USER root

WORKDIR /app

COPY ./autho/start.sh ./start.sh
RUN chmod +x ./start.sh

COPY ./autho/conf/ ./conf/

RUN chown -R ory /app/* /app/conf/*
USER ory

ENV AUTHO_PORT=20000 \
    AUTHO_AUTHE_URL=http://localhost:21000 \
    AUTHO_WEBAUTH_PUBLIC_URL=http://localhost:23000

EXPOSE 20000

ENTRYPOINT ["./start.sh"]
CMD []
