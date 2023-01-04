{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.2.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-/n8GyKcTsus7BWspg6Br4ALH98A1dSpkNFNKkRlIqHs=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-85k6XWe12m2siejfoPJru87/AYdVSl+ag09jUkBIc0M=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/v2ray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/v2fly/v2ray-core/";
    license = lib.licenses.mit;
  };
}