{ inputPackage, stdenv, dpkg }:

stdenv.mkDerivation rec {
  name = "${inputPackage.pname}-deb";
  src = ./.;
  nativeBuildInputs = [ dpkg ];
  buildInputs = [ inputPackage ];
  phases = [ "installPhase" ];

  debArch = {
    x86_64 = "amd64";
    arm64 = "arm64";
  }.${inputPackage.stdenv.targetPlatform.linuxArch} or (throw "Unsupported architecture: ${inputPackage.stdenv.targetPlatform.linuxArch}");

  debControlFile = ''
    Package: ${inputPackage.pname}
    Description: ${inputPackage.pname}
    Version: ${inputPackage.version}
    Section: base
    Priority: optional
    Architecture: ${debArch}
    Maintainer: Mark Pashmfouroush <mark@markpash.me>
  '';

  installPhase = ''
    mkdir -p $out
    temp=$(mktemp -d)
    mkdir -p "$temp/usr/bin"
    mkdir -p "$temp/DEBIAN"
    cp ${inputPackage}/bin/* "$temp/usr/bin/"
    echo "${debControlFile}" > "$temp/DEBIAN/control"
    dpkg-deb -Zxz -z9 --build "$temp" "$out"
    rm -rf "$temp"
  '';
}
