{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mtg";
  version = "2.1.7";

  src = fetchFromGitHub {
    owner = "9seconds";
    repo = "mtg";
    rev = "v${version}";
    sha256 = "sha256-7AJeiTyss/PlIMkTcCIwFrEmRIQYjleUXDUqjYfj/PM=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-OCwJ0oBAHBoAyKTsacos4iZdOiX2iZ5XJBt6PopRxWo=";

  tags = [ "netgo" ];
  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X main.version=${version}"
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/9seconds/mtg";
    license = lib.licenses.mit;
  };
}
