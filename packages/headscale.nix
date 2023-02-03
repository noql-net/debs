{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "headscale";
  version = "0.20.0";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    sha256 = "sha256-RqJrqY1Eh5/TY+vMAO5fABmeV5aSzcLD4fX7j1QDN6w=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-8p5NFxXKaZPsW4B6NMzfi0pqfVroIahSgA0fukvB3JI=";

  tags = [ "ts2019" ];
  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/juanfont/headscale/cmd/headscale/cli.Version=${version}"
  ];
  subPackages = [ "cmd/headscale" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/juanfont/headscale";
    license = lib.licenses.bsd3;
  };
}
