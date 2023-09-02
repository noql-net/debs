{ lib, pkgs, oven }:

let
  dpkg = pkgs.dpkg;
  stdenv = pkgs.stdenv;

  staticPackages = {
    age = oven.age;
    brook = oven.brook;
    chisel = oven.chisel;
    clash = oven.clash;
    clash-meta = oven.clash-meta;
    cloak = oven.cloak;
    daze = oven.daze;
    dive = oven.dive;
    dnscrypt-proxy2 = oven.dnscrypt-proxy2;
    dtlspipe = oven.dtlspipe;
    gg = oven.gg;
    glider = oven.glider;
    go-shadowsocks2 = oven.go-shadowsocks2;
    gost = oven.gost;
    gping = oven.gping;
    headscale = oven.headscale;
    hysteria = oven.hysteria;
    juicity = oven.juicity;
    lyrebird = oven.lyrebird;
    mieru = oven.mieru;
    mtg = oven.mtg;
    mwgp = oven.mwgp;
    ooniprobe-cli = oven.ooniprobe-cli;
    outline-ss-server = oven.outline-ss-server;
    prometheus-alertmanager = oven.prometheus-alertmanager;
    prometheus-blackbox-exporter = oven.prometheus-blackbox-exporter;
    psiphon-tunnel-core = oven.psiphon-tunnel-core;
    shadow-tls = oven.shadow-tls;
    shadowsocks-rust = oven.shadowsocks-rust;
    shadowsocks-v2ray-plugin = oven.shadowsocks-v2ray-plugin;
    shadowsocks-xray-plugin = oven.shadowsocks-xray-plugin;
    sing-box = oven.sing-box;
    trojan-go = oven.trojan-go;
    tuic = oven.tuic;
    tun2socks = oven.tun2socks;
    v2ray-core = oven.v2ray-core;
    wireproxy = oven.wireproxy;
    wiretap = oven.wiretap;
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
