{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gg";
  version = "0.2.17";

  src = fetchFromGitHub {
    owner = "mzz2017";
    repo = "gg";
    rev = "v${version}";
    sha256 = "sha256-UhRsgUz9au7e47cS6yrIJXc/8ZxVDpMHWBjoAcw+oCM=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-EiBt2SxUQY05Wr7KJbK+fs3U3iSmqECJ0glS8B2Ox9Q=";

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
