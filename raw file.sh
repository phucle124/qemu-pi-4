sudo ifconfig tap1 192.168.1.15 up
sudo sysctl -w net-ipv4.ip_forward=1

qemu-system-aarch64 -M virt -m 8192 -smp 8 -cpu cortex -a72 \
-kernel vmlinuz-5.10.0-21-arm64 \
-initrd initrd.img-5.10.0-21-arm64 \
-drive if-none, file-raspi_4_bullseye.img,format-raw, id-hd \
-append 'root=/dev/vda2 noresune' \
-device virtio-blk-pci.drive-hd \
-device virtio-net-pci.netdev-nynet \
-netdev user, id-mynet, hostfwd-tcp::2222-22 \
-device virtio-rng-pci-no-reboot-nographic \
-net nic net tap, ifnane-tapl, script-no net socket, Listen Localhost:8080 \