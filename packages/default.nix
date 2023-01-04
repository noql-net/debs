{ pkgs, targetPkgs }:

let
  lib = pkgs.lib;

  buildGoModuleTarget = pkgs.buildGoModule.override {
    go = targetPkgs.buildPackages.go;
    stdenv = targetPkgs.stdenv;
  };

  staticGoPackages = lib.attrsets.genAttrs [
    "cloak"
    "go-shadowsocks2"
    "gost"
    "hysteria"
    "mieru"
    "ooniprobe-cli"
    "shadowsocks-v2ray-plugin"
    "shadowsocks-xray-plugin"
    "tun2socks"
    "v2ray-core"
    "xray-core"
  ] (name: with pkgs; (import ./${name}.nix) {
    inherit lib fetchFromGitHub;
    buildGoModule = buildGoModuleTarget;
  });

  debPackages = lib.attrsets.mapAttrs' (pkgName: inputPackage:
    lib.attrsets.nameValuePair (pkgName + "-deb") (
      with pkgs; (import ../toolbox/deb.nix) { inherit inputPackage stdenv dpkg; }
    )
  ) staticGoPackages;

  all-deb = { all-deb = with pkgs; (import ../toolbox/all-deb.nix) { inherit lib stdenv; debs = debPackages; }; };
in

staticGoPackages // debPackages // all-deb
