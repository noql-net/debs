{ lib, stdenv, fetchFromGitHub, buildRustPackage, rust }:

buildRustPackage rec {
  pname = "gping";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "orf";
    repo = "gping";
    rev = "gping-v${version}";
    sha256 = "sha256-+A+j729DKlvzBjJBVMvZgl5dcIGZcLdxyGT9lLX+7yU=";
  };

  cargoSha256 = "sha256-yBpc8kS/9krriK/RkODvEsAepecU7yhY8Io46Xq3Lk8=";

  doCheck = false;

  rustTargetUpper = lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] (rust.toRustTarget stdenv.hostPlatform));
  "CARGO_TARGET_${rustTargetUpper}_LINKER" = "${stdenv.cc.targetPrefix}cc";

  meta = {
    homepage = "https://github.com/orf/gping";
    license = lib.licenses.mit;
  };
}
