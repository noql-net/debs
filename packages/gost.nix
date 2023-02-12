{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc6";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    sha256 = "sha256-iRwfmZUrQz7NtmwJkkcFW3yNN7u2F259K35a74whW7A=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-rABtB2tLxX3YZHAsQrPvz3ICTltZJm5ViCNjJ7qVjG0=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
