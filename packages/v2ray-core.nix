{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "v2ray-core";
  version = "5.3.0";

  src = fetchFromGitHub {
    owner = "v2fly";
    repo = "v2ray-core";
    rev = "v${version}";
    hash = "sha256-LLvAoPA3rLGfhrWD37OVyWd4tC9mwgpE1WjK2pY27xU=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-xBNVyPN9PRkraPRzZXOguGemYPm+Jw8hl04vWV8TZaA=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/v2ray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/v2fly/v2ray-core";
    license = lib.licenses.mit;
  };
}
