{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.7.5";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    sha256 = "sha256-WCku/7eczcsGiIuTy0sSQKUKXlH14TpdVg2/ZPdaiHQ=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-2P7fI7fUnShsAl95mPiJgtr/eobt+DMmaoxZcox0eu8=";

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
