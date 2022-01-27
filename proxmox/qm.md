# qm

## Resize disk

https://pve.proxmox.com/wiki/Resize_disks

```shell
qm resize 6063 virtio0 +100G

# Login to 6062
sudo -i
dmesg | grep vda
fdisk -l /dev/vda | grep ^/dev
parted /dev/vda
    print
    F
    resizepart 1 100%
    quit
fdisk -l /dev/vda | grep ^/dev
reboot
```