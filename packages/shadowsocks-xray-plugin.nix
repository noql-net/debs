{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-xray-plugin";
  version = "1.7.5";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "xray-plugin";
    rev = "v${version}";
    sha256 = "sha256-WPblKj1xv30V+dkT7bARz796644LKvgnt9hiDigYPHo=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-gb6fQPuyiCfkCoFyvLXL+UGNAl2F09yVjLFIcKcodYI=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/xray-plugin";
    license = lib.licenses.mit;
  };
}
