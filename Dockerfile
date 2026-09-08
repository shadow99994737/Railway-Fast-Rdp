FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Lightweight desktop (XFCE) instead of heavy GNOME - much smoother over RDP
RUN apt-get update && apt-get install -y --no-install-recommends \
    dbus \
    xrdp \
    xorgxrdp \
    xfce4 \
    xfce4-terminal \
    xfce4-goodies \
    dbus-x11 \
    sudo \
    wget \
    curl \
    nano \
    chromium \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user (RDP works better with non-root login)
RUN useradd -m -s /bin/bash rdpuser && \
    echo "rdpuser:rdppass123" | chpasswd && \
    adduser rdpuser sudo

# Use xorgxrdp backend (much faster than default vnc-based xrdp session)
RUN sed -i 's/port=3389/port=3389\nuse_vsock=false/' /etc/xrdp/xrdp.ini && \
    sed -i 's/max_bpp=32/max_bpp=16/g' /etc/xrdp/xrdp.ini && \
    sed -i 's/xserverbpp=24/xserverbpp=16/g' /etc/xrdp/xrdp.ini

# Set XFCE as the default session (lighter than GNOME)
RUN echo "xfce4-session" > /home/rdpuser/.xsession && \
    chown rdpuser:rdpuser /home/rdpuser/.xsession

# Disable heavy visual effects / compositing for speed
RUN mkdir -p /home/rdpuser/.config/xfce4/xfconf/xfce-perchannel-xml
COPY xfwm4.xml /home/rdpuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
RUN chown -R rdpuser:rdpuser /home/rdpuser/.config

# Proper startup script (container has no init system, so 'service' command doesn't work)
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3389

CMD ["/start.sh"]
