{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.2.1";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-Q7yro9jHNr+HSJkoO7D+T05+AK26eLtw9NfvDTWeMw8=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-uXxqqPNSa2s1KmBPzvYVdTmOLxaWer9+AupdvL3+qYU=";

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
