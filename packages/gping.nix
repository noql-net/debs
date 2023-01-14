{ lib, stdenv, fetchFromGitHub, buildRustPackage, rust }:

buildRustPackage rec {
  pname = "gping";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "orf";
    repo = "gping";
    rev = "gping-v${version}";
    sha256 = "sha256-eC043Bjtmb/qlA8OWixeBbbbLVgALDkFqQWzN6dpG/A=";
  };

  cargoSha256 = "sha256-lRSlfscBzKP2Kny7MA/aFrV5sAzQw1w1WZo3CzLCK88=";

  doCheck = false;

  rustTargetUpper = lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] (rust.toRustTarget stdenv.hostPlatform));
  "CARGO_TARGET_${rustTargetUpper}_LINKER" = "${stdenv.cc.targetPrefix}cc";

  meta = {
    homepage = "https://github.com/orf/gping";
    license = lib.licenses.mit;
  };
}
