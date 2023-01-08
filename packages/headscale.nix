{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "headscale";
  version = "0.17.1";

  src = fetchFromGitHub {
    owner = "juanfont";
    repo = "headscale";
    rev = "v${version}";
    sha256 = "sha256-/NJUtmH67VZERCvExcX4W4T9Rcixc5m28ujNcrQduWg=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-Y1IK9Tx2sv0v27ZYtSxDP9keHQ7skctDOa+37pNGEC8=";

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
