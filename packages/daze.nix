{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "daze";
  version = "1.18.2";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    sha256 = "sha256-QlQM2LhImFwldonVv/DCW7jhhnc4E6htd2+g2jcL8yo=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-QONhNOlDEF5GdVfucDTbwVtFpOLcQxmbxy7IusmUVx8=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/daze" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mohanson/daze";
    license = lib.licenses.mit;
  };
}
