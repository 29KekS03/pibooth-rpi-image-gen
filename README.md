# Pibooth OS Image Generator (rpi-image-gen)

Dieses Repository erstellt ein vorkonfiguriertes Raspberry Pi OS Image für den Einsatz mit [Pibooth](https://github.com/pibooth/pibooth) – optimiert für den Raspberry Pi 5.

## Features

- Autologin für Benutzer `pi`
- Autostart von Pibooth über X11/Openbox
- Integration von USB-Konfigurationsordner (`pibooth-config`)
- Overlay-Root-Unterstützung möglich
- GitHub Actions Unterstützung für automatisierten Image-Build

## Struktur

```text
.
├── config/               # Basiskonfiguration (User, Hostname, etc.)
├── meta/                 # Paketdefinitionen (z.B. pibooth.yaml)
├── profile/              # Build-Profil, das meta & hooks kombiniert
├── device/hooks/         # Anpassungsskripte (z.B. Autostart, USB-Setup)
├── image/                # genimage Layout-Konfiguration
└── .github/workflows/    # GitHub Actions Workflow (build.yml)
```

## Quickstart (lokal)

1. System vorbereiten:

```bash
sudo apt update
sudo apt install -y   debootstrap dosfstools mtools qemu-user-static   binfmt-support libarchive-tools   parted python3-yaml rsync xz-utils
```

2. rpi-image-gen klonen:

```bash
git clone https://github.com/RPi-Distro/rpi-image-gen.git
```

3. Image bauen:

```bash
cd rpi-image-gen
sudo ./build.sh ../config/image.ini ../profile/pibooth.profile
```

Das fertige Image findest du unter `rpi-image-gen/workspace/images/pibooth-os.img`.

## GitHub Actions

Bei jedem Push nach `main` wird automatisch ein neues Image gebaut und als Artifact bereitgestellt.

## USB-Konfiguration

Stecke einen USB-Stick ein mit folgendem Ordner:
```text
/pibooth-config/
├── layout/
├── pictures/
└── config.cfg
```

Beim Booten wird diese Konfiguration automatisch übernommen (wenn vorhanden).

---

MIT Lizenz – von [29KekS03](https://github.com/29KekS03) und ChatGPT
