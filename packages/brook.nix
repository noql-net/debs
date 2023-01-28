{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "brook";
  version = "20230122";

  src = fetchFromGitHub {
    owner = "txthinking";
    repo = "brook";
    rev = "v${version}";
    sha256 = "sha256-M4AYbHbnRDvG55AvfRpcdpK4MU/cM1RBqn0JzhsKgsk=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-sJbWAytX3JhFbaTwZHgGNv9rPNTwn0v/bbeaIsfyBro=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cli/brook" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/txthinking/brook";
    license = lib.licenses.gpl3Plus;
  };
}
