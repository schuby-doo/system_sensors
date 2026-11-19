FROM python:3.15.2-alpine3.24
LABEL org.opencontainers.image.source="https://github.com/schuby-doo/system_sensors"

ENV YES_YOU_ARE_IN_A_CONTAINER=True

# Apply security updates. --no-cache fetches a fresh index for this call only
# (no separate "apk update" needed) and keeps it out of the image.
RUN apk upgrade --no-cache \
 && mkdir -p /app/config /app/host

# Upgrade pip first, then install the dependencies with the upgraded pip.
COPY requirements.txt /app/
RUN pip install --no-cache-dir --disable-pip-version-check --upgrade pip \
 && pip install --no-cache-dir --disable-pip-version-check --upgrade -r /app/requirements.txt

COPY src/ /app/
RUN chmod a+x /app/bin/system_sensors.sh

# Exec form: no extra "sh -c" wrapper, so signals (docker stop) reach the process directly.
CMD ["/app/bin/system_sensors.sh"]
