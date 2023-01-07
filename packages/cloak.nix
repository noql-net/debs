{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "cloak";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "cbeuw";
    repo = "Cloak";
    rev = "v${version}";
    sha256 = "sha256-yZwxVA7Ar0WS9wvtR9g1xj1kH62OOrc+5SaAaY7SZ9Q=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-8k+FZKvB9aMoCBpjCFwcDF9/KnPhOjpCt5rSJWO8AXk=";

  ldflags = [ "-s" "-w" "-buildid=" "-X main.version=${version}" ];
  subPackages = [ "cmd/ck-client " "cmd/ck-server" ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/cbeuw/Cloak";
    license = lib.licenses.gpl3Plus;
  };
}
