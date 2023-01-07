{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "shadowsocks-v2ray-plugin";
  version = "5.2.0";

  src = fetchFromGitHub {
    owner = "teddysun";
    repo = "v2ray-plugin";
    rev = "v${version}";
    sha256 = "sha256-gFqZp8DwcyJ6oNc0iYoMfzeHAU7q3cQJBrPsxfCagkQ=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-IqAtD9YNOeBMTXlassqNKDfEr9IWWDUfONXbcBqWQfE=";

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/teddysun/v2ray-plugin";
    license = lib.licenses.mit;
  };
}
