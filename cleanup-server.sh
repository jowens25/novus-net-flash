#!/bin/bash

#set -e

cwd="$(cd -- "$(dirname -- "$0")" && pwd)"

rm "$cwd/rootfs.tar.gz" 
rm -rf "$cwd/rootfs_debian_nfs"
rm -rf "$cwd/tftpboot"

sudo apt-get purge nfs-kernel-server
sudo apt purge tftpd-hpa


