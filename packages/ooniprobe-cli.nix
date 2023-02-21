{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ooniprobe-cli";
  version = "3.17.0";

  src = fetchFromGitHub {
    owner = "ooni";
    repo = "probe-cli";
    rev = "v${version}";
    hash = "sha256-xOWGRDK9HyKU/WrLSLgmKpF82UTxxgIMOL1zCQDjtpU=";
  };

  vendorHash = "sha256-r8kyL9gpdDesY8Mbm4lONAhWC4We26Z9uG7QMt1JT9c=";
  CGO_ENABLED = 1;

  ldflags = [ "-s" "-w" "-buildid=" ];

  subPackages = [ "cmd/ooniprobe" ];
  doCheck = false;

  meta = {
    homepage = "https://github.com/ooni/probe-cli";
    license = lib.licenses.gpl3Plus;
  };
}
