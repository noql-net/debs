{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "hysteria";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "v${version}";
    sha256 = "sha256-CQgCFtvQDvhHTk10gpxfAvEJLz/i+CXXyzGrxi26hBk=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";

  vendorSha256 = "sha256-C74JXgE6tc2w2ziG8QzFYGnHYuLZcKWxSf/Htg/BeFo=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/cmd $out/bin/hysteria
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/apernet/hysteria";
    license = lib.licenses.mit;
  };
}
