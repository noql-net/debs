{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "xray-core";
  version = "1.7.2";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    sha256 = "sha256-jwCvo6+YXC471VqGWzcrnrLWOSJW2tBKa5SoynQg0Lo=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-P2g0MqlBScm6yTnpvL5T6l9ntsb4tK9k3Civ7rTevrE=";

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
