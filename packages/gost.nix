{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc.3";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    sha256 = "sha256-pvTQE+ODMaJ3tm/pG+PzeMQtNUb5eEP5eDtG/uRBPQI=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-VSvvWLQZKRBoWEeB0xS92e/wm4zV//aaWdt3OZ3ZBHQ=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
