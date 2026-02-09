#!/bin/bash

set -e

cwd="$(cd -- "$(dirname -- "$0")" && pwd)"

echo "Setting up in... $cwd"

mkdir -p "$cwd/rootfs_debian_nfs"

curl -L -o rootfs.tar.gz https://github.com/jowens25/novus-5.4.85-1.0/raw/main/rootfs.tar.gz
#sudo tar xzvf "$cwd/rootfs.tar.gz" -C "$cwd/rootfs_debian_nfs"

#sudo apt-get install nfs-kernel-server
#sudo apt install tftpd-hpa

echo "Configuring NFS export..."
sudo tee /etc/exports > /dev/null <<EOF
$cwd/rootfs_debian_nfs    *(rw,sync,no_root_squash,no_all_squash,no_subtree_check)
EOF


echo "Configuring tftpd-hpa..."
sudo tee /etc/default/tftpd-hpa > /dev/null <<EOF
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="$cwd/tftpboot"
TFTP_ADDRESS="0.0.0.0:69"
TFTP_OPTIONS="--secure --create --verbose"
EOF

#pwd

sudo mkdir -p "$cwd/tftpboot"
sudo chmod -R 777 "$cwd/tftpboot"
sudo cp "$cwd"/rootfs_debian_nfs/boot/*.dtb "$cwd"/tftpboot
sudo cp "$cwd/rootfs_debian_nfs/boot/Image.gz" "$cwd/tftpboot"

echo "Restarting nfs and tftpd..."
sudo /etc/init.d/nfs-kernel-server restart
sudo /etc/init.d/tftpd-hpa restart


echo "===> Connect with a serial terminal..."
echo "===> Enter u-boot by pressing any key during boot then run:"
echo "===> setenv serverip <your host ip address>"
echo "===> setenv nfsroot $cwd/rootfs_debian_nfs"
echo "===> setenv bootcmd 'run netboot'"
echo "===> saveenv"
echo "===> boot"
echo "===> Then once booted run install_debian.sh to reflash system"