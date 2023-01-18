{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "prometheus-alertmanager";
  version = "0.25.0";

  src = fetchFromGitHub {
    owner = "prometheus";
    repo = "alertmanager";
    rev = "v${version}";
    hash = "sha256-h87m3flE2GRAXMBgaAC+sOsPWEs7l9loQt6jGaSdXfQ=";
  };

  CGO_ENABLED = 0;

  vendorHash = "sha256-BX4mT0waYtKvNyOW3xw5FmXI8TLmv857YBFTnV7XXD8=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/prometheus/common/version.Version=${version}"
    "-X github.com/prometheus/common/version.Revision=v${version}"
    "-X github.com/prometheus/common/version.Branch=unknown"
    "-X github.com/prometheus/common/version.BuildUser=unknown"
    "-X github.com/prometheus/common/version.BuildDate=unknown"
  ];
  subPackages = [ "cmd/alertmanager" "cmd/amtool" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/prometheus/alertmanager";
    license = lib.licenses.asl20;
  };
}
