{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.16.7";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-GebDgdz45INM1Sf7T0qDjFeBqRftMHjGLIAWTM/1REY=";
  };

  vendorHash = "sha256-eH+PfclxqgffM/pzIkdl7x+6Ie6UPyUpWkJ7+G5eN/E=";
  CGO_ENABLED = 1;

  ldflags = [ "-s" "-w" "-buildid=" ];

  subPackages = [ "cmd/ooniprobe" ];
  doCheck = false;

  meta = {
    homepage = "https://ooni.org/install/cli";
    license = lib.licenses.gpl3Plus;
  };
}