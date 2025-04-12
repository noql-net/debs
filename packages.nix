{ lib, pkgs, oven }:

let
  dpkg = pkgs.dpkg;
  stdenv = pkgs.stdenv;

  staticPackages = {
    bepass = oven.bepass;
    bepass-relay = oven.bepass-relay;
    brook = oven.brook;
    chisel = oven.chisel;
    clash = oven.clash;
    cloak = oven.cloak;
    daze = oven.daze;
    dnscrypt-proxy2 = oven.dnscrypt-proxy2;
    dtlspipe = oven.dtlspipe;
    gg = oven.gg;
    glider = oven.glider;
    go-shadowsocks2 = oven.go-shadowsocks2;
    gost = oven.gost;
    headscale = oven.headscale;
    hysteria = oven.hysteria;
    juicity = oven.juicity;
    lyrebird = oven.lyrebird;
    mieru = oven.mieru;
    mihomo = oven.mihomo;
    mtg = oven.mtg;
    mwgp = oven.mwgp;
    ooniprobe-cli = oven.ooniprobe-cli;
    outline-ss-server = oven.outline-ss-server;
    psiphon-tunnel-core = oven.psiphon-tunnel-core;
    shadowsocks-rust = oven.shadowsocks-rust;
    shadowsocks-v2ray-plugin = oven.shadowsocks-v2ray-plugin;
    shadowsocks-xray-plugin = oven.shadowsocks-xray-plugin;
    sing-box = oven.sing-box;
    trojan-go = oven.trojan-go;
    tuic = oven.tuic;
    tun2socks = oven.tun2socks;
    v2ray-core = oven.v2ray-core;
    wireproxy = oven.wireproxy;
    xray-core = oven.xray-core;
    xray-knife = oven.xray-knife;
  };

  debPackages = lib.attrsets.mapAttrs'
    (pkgName: inputPackage:
      lib.attrsets.nameValuePair (pkgName + "-deb") (
        (import ./toolbox/deb.nix) { inherit inputPackage stdenv dpkg; }
      )
    )
    (staticPackages);

  all-deb = { all-deb = (import ./toolbox/all-deb.nix) { inherit lib stdenv; debs = debPackages; }; };
in

staticPackages // debPackages // all-deb
