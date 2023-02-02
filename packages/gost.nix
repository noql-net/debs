{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc.4";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    sha256 = "sha256-40nogMDDlZk11560BDZg9Glv3L9DqGx8QL9z034yYrk=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-3/+qh81P1kcjHd4kGOVf6rztM12wcLHhcIz5zx6l5Bk=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
