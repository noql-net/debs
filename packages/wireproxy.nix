{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "wireproxy";
  version = "1.0.5";

  src = fetchFromGitHub {
    owner = "octeep";
    repo = "wireproxy";
    rev = "v${version}";
    sha256 = "sha256-5xyKmFxXYhrR8EbG1/ByD10lhkPT9Ky1lq+LL2djaao=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-/LZs6N2m5nHx735Ug+PcM1I1ZL9f8VYEpd7Tt4WizMQ=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
  ];
  subPackages = [ "cmd/wireproxy" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/octeep/wireproxy";
    license = lib.licenses.isc;
  };
}
