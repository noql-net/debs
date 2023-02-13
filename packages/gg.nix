{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gg";
  version = "0.2.18";

  src = fetchFromGitHub {
    owner = "mzz2017";
    repo = "gg";
    rev = "v${version}";
    sha256 = "sha256-07fP3dVFs4MZrFOH/8/4e3LHjFGZd7pNu6J3LBOWAd8=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-fnM4ycqDyruCdCA1Cr4Ki48xeQiTG4l5dLVuAafEm14=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/mzz2017/gg/cmd.Version=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mzz2017/gg";
    license = lib.licenses.agpl3Plus;
  };
}
