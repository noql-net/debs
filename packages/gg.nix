{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gg";
  version = "0.2.16";

  src = fetchFromGitHub {
    owner = "mzz2017";
    repo = "gg";
    rev = "v${version}";
    sha256 = "sha256-zdOcQ/+WXS7pDfnvYdb/FDjMT3yJdwnS8DoH2MIDcDs=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-kx94B1XIXWJOY9Y69lNb/sHWVjsuFuOXrdtJFJrUuAs=";

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
