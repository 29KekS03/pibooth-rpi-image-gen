#!/bin/bash
set -eux

# Debian & RPi GPG Keys
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
  0E98404D386FA1D9 \
  6ED0E7B82643E131 \
  F8D2585B8783D481 \
  54404762BBB6E853 \
  BDE6D2B9216EC7A8 \
  82B129927FA3303E