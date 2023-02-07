{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "outline-ss-server";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "Jigsaw-Code";
    repo = "outline-ss-server";
    rev = "v${version}";
    sha256 = "sha256-fUCe9WlayvQ8QBplYGkTAscCx+BzkZuyOyfkNhgeP8Q=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-qtog1KMtosK9COADp4HaRr9TucPQCjHM2siq//w/0lo=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Jigsaw-Code/outline-ss-server";
    license = lib.licenses.asl20;
  };
}
