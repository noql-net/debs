{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "chisel";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "jpillora";
    repo = "chisel";
    rev = "v${version}";
    sha256 = "sha256-N2voSclNH7lGbUkZo2gkrEb6XoA5f0BzNgAzQs1lOKQ=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-p/5g4DLoUhEPFBtAbMiIgc6O4eAfbiqBjCqYkyUHy70=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/jpillora/chisel/share.BuildVersion=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/jpillora/chisel";
    license = lib.licenses.mit;
  };
}
