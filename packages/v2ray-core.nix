{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.4.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-dgWpfpJiPYQmVg7CHRE8f9hX5vgC2TuLpTfMAksDurs=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-BEMdh1zQdjVEu0GJt6KJyWN5P9cUHfs04iNZWxzZ0Yo=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/v2ray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/v2fly/v2ray-core";
    license = lib.licenses.mit;
  };
}
