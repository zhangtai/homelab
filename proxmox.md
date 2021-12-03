# Proxmox

## Infrastructure


- Database: 5001, lxc container with postgres


- Object storage: 5002

## Create templates

TBC

## Create VM

```shell
qm clone 2002 111 --full --name iot
```

## New Container

```shell
export PCT_ID=4000
export PCT_HOST=lxc-dev
export PCT_IP=192.168.3.40
pct create ${PCT_ID} local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz \
  --cpulimit 4 \
  --memory 2048 \
  --storage local-lvm \
  --rootfs local-lvm:50 \
  --ostype ubuntu \
  --ssh-public-keys /root/pubKeys/mbp.key \
  --start 1 \
  --hostname ${PCT_HOST} \
  --unprivileged 1 \
  --net0 name=eth0,bridge=vmbr0,firewall=1,gw=192.168.3.1,ip=${PCT_IP}/24,type=veth

pct destroy 4000 --force
```
