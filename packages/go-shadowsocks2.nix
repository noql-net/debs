{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "go-shadowsocks2";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "shadowsocks";
    repo = "go-shadowsocks2";
    rev = "v${version}";
    sha256 = "sha256-z2+5q8XlxMN7x86IOMJ0qbrW4Wrm1gp8GWew51yBRFg=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-RrHksWET5kicbdQ5HRDWhNxx4rTi2zaVeaPoLdg4uQw=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/shadowsocks/go-shadowsocks2";
    license = lib.licenses.asl20;
  };
}
