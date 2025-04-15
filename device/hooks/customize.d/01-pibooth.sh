#!/bin/bash
set -eux

echo "✅ Konfiguriere Pibooth OS..."

# Autologin aktivieren
mkdir -p /etc/systemd/system/getty@tty1.service.d
cat <<EOF > /etc/systemd/system/getty@tty1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin pi --noclear %I $TERM
EOF

# .xinitrc + Autostart
cat <<'EOF' > /home/pi/.xinitrc
#!/bin/bash
openbox-session &
pibooth
EOF
chmod +x /home/pi/.xinitrc
chown pi:pi /home/pi/.xinitrc

# USB-Config Script
cat <<'EOF' > /usr/local/bin/pibooth-usb-setup.sh
#!/bin/bash
set -e
MOUNT_BASE="/media/pi"
USB_PATH=$(find "$MOUNT_BASE" -maxdepth 1 -type d -name '*' -not -name 'pi' | head -n1)
TARGET_DIR="/home/pi/.config/pibooth"
if [ -d "$USB_PATH/pibooth-config" ]; then
    cp -r "$USB_PATH/pibooth-config/"* "$TARGET_DIR/"
else
    echo "⚠️ Keine USB-Konfiguration gefunden. Verwende SD-Standard."
fi
chown -R pi:pi "$TARGET_DIR"
EOF
chmod +x /usr/local/bin/pibooth-usb-setup.sh

# systemd Service für das USB-Setup
cat <<EOF > /etc/systemd/system/pibooth-usb-setup.service
[Unit]
Description=Lade Pibooth-Konfiguration von USB
After=local-fs.target
Wants=media-pi.mount

[Service]
Type=oneshot
ExecStart=/usr/local/bin/pibooth-usb-setup.sh
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
EOF

systemctl enable pibooth-usb-setup.service
