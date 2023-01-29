{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "clash";
  version = "1.13.0";

  src = fetchFromGitHub {
    owner = "Dreamacro";
    repo = "clash";
    rev = "v${version}";
    sha256 = "sha256-f/iSnSaRr1dqMRKb7GDZdc2WuykO42XMSNKwMOwuagc=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-fDn6UlijI2TJPF4FS50u1MMDxnd8eDTbqHLnGso/FoU=";

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
