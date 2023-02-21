{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-v2ray-plugin";
  version = "5.4.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    sha256 = "sha256-QTuyMMjctnimsKxtkVjIjafQLXYc08D6UX+lwNsT6MI=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-MBjEM2S2G+8vfFmNqCsW5SRPvX6eo9rEuluvCPln4EQ=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/v2ray-plugin";
    license = lib.licenses.mit;
  };
}
