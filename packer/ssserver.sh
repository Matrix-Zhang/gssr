#!/bin/bash -e

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' | # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
}

if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root!" 1>&2
  exit 1
fi

tag=$(get_latest_release "shadowsocks/shadowsocks-rust")

if [[ -z "${tag}" ]]; then
  echo "Error: Failed to get shadowsocks-rust's latest tag."
  exit 1
fi

target="shadowsocks.tar.xz"

wget "https://github.com/shadowsocks/shadowsocks-rust/releases/download/${tag}/shadowsocks-${tag}-stable.x86_64-unknown-linux-musl.tar.xz" -O ${target}

if [[ $? -eq 0 ]]; then
  tar -xf ${target}
  if [[ ! -f ssserver ]]; then
    echo "Error: Ssserver not found!"
    exit 2
  fi
  mv ssserver /usr/bin/
  chmod +x /usr/bin/ssserver
fi
