{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mieru";
  version = "1.12.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    sha256 = "sha256-e7OovkdNapIolM5g2E2ph1JLV7+NvXpZWNCdfoVM2Zk=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-vC1fhep8UIevIrf3EnRW1ouCTnVqxCPy2J6MSPryNuo=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/mieru" "cmd/mita" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/enfein/mieru";
    license = lib.licenses.mit;
  };
}
