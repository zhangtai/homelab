# OpnSense install v2ray

## Install ports

- https://docs.opnsense.org/manual/software_included.html
- https://github.com/davidmytton/cloudflared-freebsd
- https://www.freshports.org/net/cloudflared/
- https://forum.opnsense.org/index.php?topic=21233.0
- https://forum.opnsense.org/index.php?topic=2161.0

```shell
sudo https_proxy=http://localhost:8889 opnsense-code ports tools
```

- [cloudflared](https://github.com/davidmytton/cloudflared-freebsd)
- v2ray

### Install cloudflared

```shell
cd /usr/ports/lang/go && sudo make install clean

# /usr/ports/distfiles/
```

- Remove `BATCH` variable from `/etc/make.conf`


## Install v2ray

### Manual install v2ray

1. Download binary from v2flay/v2ray-core
1. Extract as /usr/share/v2ray-freebsd-64
1. Create a startup script: `/usr/local/etc/rc.syshook.d/start/96-v2ray`
    ```shell
    #!/bin/sh
    cd /tmp && nohup /usr/share/v2ray-freebsd-64/v2ray &
    ```
1. Create Firewall Rules, go to `Firewall` -> `Rules` -> `LAN`, to create:
    - Source: any
    - Destination: LAN address
    - Destination port range: 8889

## Create v2ray service on OpnSense server

- https://docs.opnsense.org/development/backend/autorun.html
