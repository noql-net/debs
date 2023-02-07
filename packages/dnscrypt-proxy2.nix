{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dnscrypt-proxy2";
  version = "2.1.4";

  src = fetchFromGitHub {
    owner = "DNSCrypt";
    repo = "dnscrypt-proxy";
    rev = "${version}";
    sha256 = "sha256-98DeCrDp0TmPCSvOrJ7KgIQZBR2K1fFJrmNccZ7nSug=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = null;

  ldflags = [ "-s" "-w" "-buildid=" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/DNSCrypt/dnscrypt-proxy";
    license = lib.licenses.isc;
  };
}
