#!/bin/bash
set -e

# Create dbus machine-id if missing
if [ ! -f /var/lib/dbus/machine-id ]; then
    dbus-uuidgen > /var/lib/dbus/machine-id
fi

# Start dbus system daemon properly (not via 'service' - no init system in container)
mkdir -p /var/run/dbus
dbus-daemon --system --fork

# Start xrdp session manager
/usr/sbin/xrdp-sesman

# Start xrdp in foreground (keeps container alive)
exec /usr/sbin/xrdp -n
