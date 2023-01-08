{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "chisel";
  version = "1.7.7";

  src = fetchFromGitHub {
    owner = "jpillora";
    repo = "chisel";
    rev = "v${version}";
    sha256 = "sha256-3EaVUGcwkJWX0FxIaHddUehJIdbxAPfBm8esXKCUuhM=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-Oko9nduKW76NIUCVyF0lPzEH+TFT1el9VGIbm5lQXtM=";

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
