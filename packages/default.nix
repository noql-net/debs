{ lib, pkgs, targetPkgs }:

let
  targetBuildPackages = targetPkgs.buildPackages;
  targetStaticStdenv = targetPkgs.pkgsStatic.stdenv;

  buildGoModuleTarget = pkgs.buildGoModule.override {
    go = targetBuildPackages.go;
    stdenv = targetStaticStdenv;
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
    (name: with pkgs; (import ./${name}.nix) {
      inherit lib fetchFromGitHub;
      buildGoModule = buildGoModuleTarget;
    });

  buildRustPackageTarget = pkgs.rustPlatform.buildRustPackage.override {
    stdenv = targetStaticStdenv;
    rustc = targetBuildPackages.rustc;
    cargoBuildHook = targetPkgs.rustPlatform.cargoBuildHook;
    cargoInstallHook = targetPkgs.rustPlatform.cargoInstallHook;
  };

  staticRustPackages = {
    shadowsocks-rust = with pkgs; (import ./shadowsocks-rust.nix) {
      inherit lib fetchFromGitHub pkg-config;
      stdenv = targetStaticStdenv;
      openssl = targetPkgs.pkgsStatic.openssl;
      rust = targetBuildPackages.rust;
      buildRustPackage = buildRustPackageTarget;
    };
  };

  debPackages = lib.attrsets.mapAttrs'
    (pkgName: inputPackage:
      lib.attrsets.nameValuePair (pkgName + "-deb") (
        with pkgs; (import ../toolbox/deb.nix) { inherit inputPackage stdenv dpkg; }
      )
    )
    (staticGoPackages // staticRustPackages);

  all-deb = { all-deb = with pkgs; (import ../toolbox/all-deb.nix) { inherit lib stdenv; debs = debPackages; }; };
in

staticGoPackages // staticRustPackages // debPackages // all-deb
