{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "daze";
  version = "1.18.4";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "daze";
    rev = "v${version}";
    sha256 = "sha256-GDiXJZds9NaAuMcPcJXHXcA8SEhxt1rQ3p0v/XTR4kQ=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-0bVgdQLOukaTUhdOYA0uGXW0Ltw86417cIQiq+SjFV4=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/daze" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/mohanson/daze";
    license = lib.licenses.mit;
  };
}
