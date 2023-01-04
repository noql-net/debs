{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "hysteria";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "apernet";
    repo = "hysteria";
    rev = "v${version}";
    sha256 = "sha256-9ib/29yCfI4oS2yZQUePzZ+5FVTevvJCPjpTXmKnKeA=";
  };

  sourceRoot = "source/app";

  CGO_ENABLED = 0;
  GOWORK = "off";

  vendorSha256 = "sha256-DGEUhgMUbB4B9+4UHqKnVw3483N3WjShEd6ZTCLDw00=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/cmd $out/bin/hysteria
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/apernet/hysteria/";
    license = lib.licenses.mit;
  };
}