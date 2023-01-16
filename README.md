# debrepo

A nix flake that is used to create an apt repository for debian-based distros containing a small selection of packages.

A live and mostly up-to-date version of the repo this flake produces is available on `apt.noql.net`. It can used by adding the following to `/etc/apt/sources.list`:

```
deb [trusted=yes] https://apt.noql.net/all all main
```

Make sure to install `ca-certificates` to be able to use https sources, and run `apt update` afterwards.

## Goals
The packages produced here are statically compiled, and target both amd64 and arm64 architectures. The arm64 packages are cross-compiled on amd64 build machines.

## Package selection
The packages that are added here are generally anti-censorship/proxy, networking, encryption/privacy related tools. The selection is updated very regularly.

If there's a tool that would be appropriate to add, please file an issue.

## Nix/NixOS users
All the packages that this flake builds are also available as outputs to the flake. This means that Nix and NixOS users can import this flake and also benefit from the selection of packages.

## Packages
```
age
brook
chisel
clash
cloak
dive
dnscrypt-proxy2
gg
go-shadowsocks2
gost
gping
headscale
hysteria
mieru
mtg
obfs4proxy
ooniprobe-cli
shadowsocks-rust
shadowsocks-v2ray-plugin
shadowsocks-xray-plugin
sing-box
trojan-go
tun2socks
v2ray-core
wireproxy
xray-core
```
