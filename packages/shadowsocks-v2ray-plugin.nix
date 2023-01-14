{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-v2ray-plugin";
  version = "5.2.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    sha256 = "sha256-nvQdi43mfXTRjCfmHESMadA38ywSN+jgPItGXCUvXMg=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-aiBu1ToV1dKAXze4oolh/BVGz/EhVAwHAnK7gXdcJS4=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/v2ray-plugin";
    license = lib.licenses.mit;
  };
}
