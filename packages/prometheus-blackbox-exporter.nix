{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "prometheus-blackbox-exporter";
  version = "0.23.0";

  src = fetchFromGitHub {
    owner = "prometheus";
    repo = "blackbox_exporter";
    rev = "v${version}";
    hash = "sha256-im/B5PM7oSE9ejcr558sJKM67UjZUXfm5dci4ZlMycA=";
  };

  CGO_ENABLED = 0;

  vendorHash = "sha256-f2m/8KvnEX0lZkmQtFOLOMj5gMUIiBKKvC+yq7QY0B4=";

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
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/prometheus/blackbox_exporter";
    license = lib.licenses.asl20;
  };
}
