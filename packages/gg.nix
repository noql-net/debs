{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gg";
  version = "0.2.15";

  src = fetchFromGitHub {
    owner = "mzz2017";
    repo = "gg";
    rev = "v${version}";
    sha256 = "sha256-INoJcb6XUMvT1E56hC3BGK3Ax+v4jSRpZV12zpjYfMA=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-kKIekANzLY2TYFyII1/BkKkqPYgmHB9xEfAVhJyI8FI=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/mzz2017/gg/cmd.Version=${version}"
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mzz2017/gg";
    license = lib.licenses.agpl3Plus;
  };
}
