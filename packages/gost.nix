{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gost";
  version = "3.0.0-rc.2";

  src = fetchFromGitHub {
    owner = "go-gost";
    repo = "gost";
    rev = "v${version}";
    sha256 = "sha256-mEdmaWSqH6I7rK223FLaYvayBt2IXh1yfsQunfv3plM=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-csuAUEFRwz6KTCY6E4p6ePYQoPwGYu+tpLQgMUaY9Qo=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "cmd/gost" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/go-gost/gost";
    license = lib.licenses.mit;
  };
}
