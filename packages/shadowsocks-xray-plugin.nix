{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.7.2";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    sha256 = "sha256-7U67S3dmhZOnQwRusk4bFTTdYvX8Wsw+DM7wotNBQrk=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-P0l/JZZDk/HkByyk8YKIIxHaqokNG/XKTCIOGAQH+c0=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
