{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    sha256 = "sha256-S1mAu7sdI0P5daXWuBZk9X3hY8rMjVQR9tXSSA8ndRg=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-8y+C1xgMj33BTEWfaknXqsR+IxkDNB+E5l4K2rYbg98=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin/";
    license = lib.licenses.mit;
  };
}