{ lib, pkgs, targetPkgs }:

let
  fetchFromGitHub = pkgs.fetchFromGitHub;
  pkg-config = pkgs.pkg-config;
  dpkg = pkgs.dpkg;

  go = targetPkgs.buildPackages.go;
  rust = targetPkgs.buildPackages.rust;
  rustc = targetPkgs.buildPackages.rustc;

  stdenv = targetPkgs.pkgsStatic.stdenv;
  openssl = targetPkgs.pkgsStatic.openssl;

  cargoBuildHook = targetPkgs.rustPlatform.cargoBuildHook;
  cargoInstallHook = targetPkgs.rustPlatform.cargoInstallHook;

  buildGoModuleTarget = pkgs.buildGoModule.override {
    inherit stdenv go;
  };

  staticGoPackages = lib.attrsets.genAttrs [
    "age"
    "chisel"
    "clash"
    "cloak"
    "dive"
    "dnscrypt-proxy2"
    "gg"
    "go-shadowsocks2"
    "gost"
    "headscale"
    "hysteria"
    "mieru"
    "obfs4proxy"
    "ooniprobe-cli"
    "shadowsocks-v2ray-plugin"
    "shadowsocks-xray-plugin"
    "trojan-go"
    "tun2socks"
    "v2ray-core"
    "xray-core"
  ]
    (name: (import ./${name}.nix) {
      inherit lib fetchFromGitHub; buildGoModule = buildGoModuleTarget;
    });

  buildRustPackageTarget = pkgs.rustPlatform.buildRustPackage.override {
    inherit stdenv rustc cargoBuildHook cargoInstallHook;
  };

  staticRustPackages = {
    shadowsocks-rust = (import ./shadowsocks-rust.nix) {
      inherit stdenv lib fetchFromGitHub pkg-config openssl rust;
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
