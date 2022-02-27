# OpnSense install v2ray

## Install ports

- https://docs.opnsense.org/manual/software_included.html
- https://github.com/davidmytton/cloudflared-freebsd
- https://www.freshports.org/net/cloudflared/
- https://forum.opnsense.org/index.php?topic=21233.0
- https://forum.opnsense.org/index.php?topic=2161.0

```shell
sh
export http_proxy=http://localhost:8889 https_proxy=http://localhost:8889
opnsense-code ports tools

# find available packages
# https://pkg.opnsense.org/FreeBSD:13:amd64/22.1/latest/All/
pkg rquery '%n (%v)'
pkg install bash vim
```
