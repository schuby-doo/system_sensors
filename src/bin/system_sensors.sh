#!/bin/sh

# if config.yaml does not exist, copy the default settings
if [ ! -f "/app/config/config.yaml" ]; then
    cat /app/settings_example.yaml > /app/config/config.yaml
fi

# exec replaces the shell, so python runs as PID 1 and receives SIGTERM on docker stop
exec python /app/system_sensors.py /app/config/config.yaml
