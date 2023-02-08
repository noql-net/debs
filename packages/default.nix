{ lib, pkgs, targetPkgs }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  pkg-config = pkgs.pkg-config;
  dpkg = pkgs.dpkg;

  go = targetPkgs.buildPackages.go_1_20;
  go_1_19 = targetPkgs.buildPackages.go;
  rust = targetPkgs.buildPackages.rust;
  rustc = targetPkgs.buildPackages.rustc;

  stdenv = targetPkgs.pkgsStatic.stdenv;
  openssl = targetPkgs.pkgsStatic.openssl;

  cargoBuildHook = targetPkgs.rustPlatform.cargoBuildHook;
  cargoInstallHook = targetPkgs.rustPlatform.cargoInstallHook;
  cargoSetupHook = targetPkgs.rustPlatform.cargoSetupHook;

  buildGoModuleTarget = pkgs.buildGoModule.override {
    inherit stdenv go;
  };

  buildGoModuleTarget119 = pkgs.buildGoModule.override {
    inherit stdenv; go = go_1_19;
  };

  staticGoPackages = lib.attrsets.genAttrs [
    "age"
    "brook"
    "chisel"
    "clash"
    "cloak"
    "daze"
    "dive"
    "dnscrypt-proxy2"
    "gg"
    "go-shadowsocks2"
    "headscale"
    "mieru"
    "mtg"
    "mwgp"
    "obfs4proxy"
    "outline-ss-server"
    "prometheus-alertmanager"
    "prometheus-blackbox-exporter"
    "shadowsocks-v2ray-plugin"
    "shadowsocks-xray-plugin"
    "sing-box"
    "trojan-go"
    "v2ray-core"
    "wireproxy"
    "xray-core"
  ]
    (name: (import ./${name}.nix) {
      inherit lib fetchFromGitHub;
      buildGoModule = buildGoModuleTarget;
    }) // (lib.attrsets.genAttrs [
    "gost"
    "hysteria"
    "ooniprobe-cli"
    "tun2socks"
  ]
    (name: (import ./${name}.nix) {
      inherit lib fetchFromGitHub;
      buildGoModule = buildGoModuleTarget119;
    }));

  buildRustPackageTarget = pkgs.rustPlatform.buildRustPackage.override {
    inherit stdenv rustc cargoBuildHook cargoInstallHook cargoSetupHook;
  };

  staticRustPackages = {
    shadowsocks-rust = (import ./shadowsocks-rust.nix) {
      inherit stdenv lib fetchFromGitHub pkg-config openssl rust;
      buildRustPackage = buildRustPackageTarget;
    };
    gping = (import ./gping.nix) {
      inherit stdenv lib fetchFromGitHub rust;
      buildRustPackage = buildRustPackageTarget;
    };
  };

  debPackages = lib.attrsets.mapAttrs'
    (pkgName: inputPackage:
      lib.attrsets.nameValuePair (pkgName + "-deb") (
        (import ../toolbox/deb.nix) { inherit inputPackage stdenv dpkg; }
      )
    )
    (staticGoPackages // staticRustPackages);

  all-deb = { all-deb = (import ../toolbox/all-deb.nix) { inherit lib stdenv; debs = debPackages; }; };
in

staticGoPackages // staticRustPackages // debPackages // all-deb
