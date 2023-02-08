{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-v2ray-plugin";
  version = "5.3.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    sha256 = "sha256-FlBbQmovxEP/7dEP99WPHz+2mr4MqeNvpP+th7Ov/y0=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-dc4BosO40tIITfa8gn7Aq244h/9NsAdp3TmevmEabVo=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/v2ray-plugin";
    license = lib.licenses.mit;
  };
}
