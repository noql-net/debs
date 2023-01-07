{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash";
  version = "1.12.0";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    sha256 = "sha256-SE+nZIatvwyc6JubMb7YUlNiJv+LYtJjFMlKEoJzEn8=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-ikcGZ1Gfxb4zBkav8MDi3+xNbvhqHIk6NhLfI2ne3ns=";

  ldflags = [
    "-s"
    "-w"
    "-buildid="
    "-X github.com/Dreamacro/clash/constant.Version=${version}"
    "-X github.com/Dreamacro/clash/constant.BuildTime="
  ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/Dreamacro/clash";
    license = lib.licenses.gpl3Plus;
  };
}
