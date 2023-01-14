{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "trojan-go";
  version = "0.10.6";

  src = fetchFromGitHub {
    owner = "p4gefau1t";
    repo = "trojan-go";
    rev = "v${version}";
    sha256 = "sha256-ZzIEKyLhHwYEWBfi6fHlCbkEImetEaRewbsHQEduB5Y=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-c6H/8/dmCWasFKVR15U/kty4AzQAqmiL/VLKrPtH+s4=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/p4gefau1t/trojan-go";
    license = lib.licenses.gpl3Plus;
  };
}
