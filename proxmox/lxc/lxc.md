# LXC

## Create lxc image

Need to install [distrobuilder](https://github.com/lxc/distrobuilder) firstly.

```shell
cd builder
sudo $HOME/go/bin/distrobuilder build-lxc ubuntu.yml ~/ContainerImages/ubuntu
```

Rename the generated `rootfs.tar.xz` file and upload to pve path `/var/lib/vz/template/cache`

```shell
scp ~/ContainerImages/ubuntu/rootfs.tar.xz pve:/var/lib/vz/template/cache/ubuntu-20211230-2.tar.xz

pct create 6002 local:vztmpl/ubuntu-20211230-2.tar.xz \
  --cpulimit 2 \
  --memory 2048 \
  --storage local-lvm \
  --rootfs local-lvm:20 \
  --ostype ubuntu \
  --ssh-public-keys /root/pubKeys/mbp.key \
  --start 1 \
  --hostname lxc6002 \
  --unprivileged 1 \
  --net0 name=eth0,bridge=vmbr0,firewall=1,gw=192.168.3.1,ip=192.168.3.62/24,type=veth
```
