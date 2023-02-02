{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc5";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    sha256 = "sha256-1vrBBGu6cWlTQbRVZeY5WHQ77Y9yL7+EYOW56QH6+Xg=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-seca9P7wDtZbKSo/l44ySJk8drFOkTSeuiSlwDgQ9zk=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
