{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "headscale";
  version = "0.18.0";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    sha256 = "sha256-0viXsBRCiaxBTTKXJngSov5M7toscQUOdXDTr1l0U3I=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-SuKT+b8g6xEK15ry2IAmpS/vwDG+zJqK9nfsWpHNXuU=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/juanfont/headscale";
    license = lib.licenses.bsd3;
  };
}
