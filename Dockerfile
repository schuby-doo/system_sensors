FROM python:3.16.0a1-alpine3.24
LABEL org.opencontainers.image.source="https://github.com/schuby-doo/system_sensors"

RUN apk update && apk upgrade
RUN mkdir -p /app/config && mkdir -p /app/host

ENV YES_YOU_ARE_IN_A_CONTAINER=True

COPY requirements.txt /app/
RUN pip install --upgrade -r /app/requirements.txt && pip install --upgrade pip

COPY src/ /app/
RUN chmod a+x /app/bin/system_sensors.sh

CMD /app/bin/system_sensors.sh
