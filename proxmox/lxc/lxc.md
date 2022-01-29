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

host_name=code-server
vmid=1001
template=ubuntu-20211230-2.tar.xz
cpu=4
memory=4096
root_disk_size=20
ip_last=11

pct create "${vmid}" "local:vztmpl/${template}" \
  --cpulimit "${cpu}" \
  --memory "${memory}" \
  --storage local-lvm \
  --rootfs "local-lvm:${root_disk_size}" \
  --ostype ubuntu \
  --ssh-public-keys /root/pubKeys/mbp.key \
  --start 1 \
  --hostname "${host_name}" \
  --unprivileged 1 \
  --net0 "name=eth0,bridge=vmbr0,firewall=1,gw=192.168.3.1,ip=192.168.3.${ip_last}/24,type=veth"
```
