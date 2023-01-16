{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mwgp";
  version = "2.1.5";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "mwgp";
    rev = "v${version}";
    sha256 = "sha256-dO4kTD3anmLcBk9MYEey6jn+PtRYYVyAW8Y9ANQmXXU=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-Ey0TYaZKX5A1QpuHgRlsa27hH2G5DFj69fk+4kSAR1o=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.MWGPVersion=${version}"
  ];
  subPackages = [ "cmd/mwgp" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/apernet/mwgp";
    license = lib.licenses.mit;
  };
}
