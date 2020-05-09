FROM python:alpine AS builder

RUN apk --no-cache add git gcc python3-dev libc-dev && \
    cd /opt && \
    git clone https://notabug.org/RemixDev/deemix.git deemix && \
    pip install --user -r deemix/requirements.txt

FROM python:alpine

LABEL description="Deemix in alpine." \
      maintainer="zer <zerpex@gmail.com>"

RUN adduser -D deemix && \
    mkdir -p /opt/deemix \
             /home/deemix/.config/deemix \
             /config \
             /downloads && \
    ln -sf /config /home/deemix/.config/deemix && \
    ln -sf /downloads /home/deemix/deemix\ Music

WORKDIR /opt/deemix

COPY --from=builder /opt/deemix .
COPY --from=builder /root/.local /home/deemix/.local

RUN chown -R deemix. /opt/deemix \
                     /home/deemix \
                     /config \
                     /downloads

ENV PATH=/home/deemix/.local/bin:$PATH

VOLUME /downloads /config

EXPOSE 33333

USER deemix

CMD [ "python3", "./server.py" ]
