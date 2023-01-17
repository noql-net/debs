{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mieru";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "enfein";
    repo = "mieru";
    rev = "v${version}";
    sha256 = "sha256-3x4hFZtpyC/NZSe6Y+K95F62xzU3ZjDwa2WTCFCVgXI=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-Pt5av6+QG6Z5Es0pMOiypgjp3c2KexlEfI90Kiop9kk=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/mieru" "cmd/mita" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/enfein/mieru";
    license = lib.licenses.mit;
  };
}
