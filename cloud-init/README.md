# cloud-init

`scp cloudimg-qemu-agent.yml pve:/var/lib/vz/snippets`

```sh
qm clone 999 998 --name cloudimg-qemu-agent
qm set 998 --ipconfig0 ip=dhcp --agent 1
qm set 998 --cicustom "user=local:snippets/cloudimg-qemu-agent.yml"
qm start 998
qm agent 998 ping # Check agent status
qm stop 998
qm template 998
```
