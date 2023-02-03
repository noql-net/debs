{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.7.3";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    sha256 = "sha256-zMo+gvNDOO8S8Xl+ejTuIkn/NsktQeSyTYDjVNrL6Wo=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-Eco8KEOvTVquJHmbPn+rgz5MGUV00dx8Da1plluqk7M=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/xray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/XTLS/Xray-core";
    license = lib.licenses.mpl20;
  };
}
