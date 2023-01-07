{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "obfs4proxy";
  version = "0.0.14";

  src = fetchFromGitHub {
    owner = "Yawning";
    repo = "obfs4";
    rev = "obfs4proxy-${version}";
    sha256 = "sha256-/d1qub/mhEzzLQFytgAlhz8ukIC9d+GPK2Hfi3NMv+M=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-7NF3yMouhjSM9SBNKHkeWV7qy0XTGnepEX28kBpbgdk=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  doCheck = false;

  meta = {
    homepage = "https://github.com/Yawning/obfs4";
    license = lib.licenses.gpl3Plus;
  };
}
