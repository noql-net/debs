{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.7.3";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    sha256 = "sha256-PqyGQOWN8yp4c3cPuTdgzPt459rnIS10TUK7pPh3pi8=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-zOfk1IhcAYzl1YlKqQHsG94pzp5svZEeAI8srlamtz0=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
