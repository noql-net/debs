{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dive";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "wagoodman";
    repo = "dive";
    rev = "v${version}";
    sha256 = "sha256-1pmw8pUlek5FlI1oAuvLSqDow7hw5rw86DRDZ7pFAmA=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-0gJ3dAPoilh3IWkuesy8geNsuI1T0DN64XvInc9LvlM=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
    "-X main.commit="
    "-X main.buildTime="
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/wagoodman/dive";
    license = lib.licenses.mit;
  };
}
