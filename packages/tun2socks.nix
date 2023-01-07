{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "tun2socks";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "xjasonlyu";
    repo = "tun2socks";
    rev = "v${version}";
    sha256 = "sha256-FBYRqxS8DJbIc8j8X6WNxl6a1YRcNrPSnNfrq/Y0fMM=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-XWzbEtYd8h63QdpAQZTGxyxMAAnpKO9Fp4y8/eeZ7Xw=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.Version=v${version}"
    "-X github.com/xjasonlyu/tun2socks/v2/internal/version.GitCommit=v${version}"
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/xjasonlyu/tun2socks";
    license = lib.licenses.gpl3Plus;
  };
}
