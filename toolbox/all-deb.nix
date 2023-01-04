{ lib, stdenv, debs }:

stdenv.mkDerivation rec {
  name = "all-deb";
  src = ./.;
  buildInputs = lib.attrsets.attrValues debs;
  phases = [ "installPhase" ];
  paths = lib.strings.concatStringsSep " " (lib.attrsets.attrValues debs);

  installPhase = ''
    mkdir -p "$out"
    for path in ${paths}
    do
      cp $path/* $out/
    done
  '';
}
