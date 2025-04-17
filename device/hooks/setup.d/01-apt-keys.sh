#!/bin/bash
set -eux

# Debian & RPi GPG Keys
- name: Add Missing GPG Keys
  run: |
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6ED0E7B82643E131
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F8D2585B8783D481
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 54404762BBB6E853
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BDE6D2B9216EC7A8
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 82B129927FA3303E

- name: Run apt-get update
  run: sudo apt-get update