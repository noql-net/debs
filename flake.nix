{
  description = "debrepo";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";

  outputs = { self, nixpkgs }: {
    packages =
      let
        builder = import ./packages;
        buildPlatformPkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      {
        x86_64-linux = (builder {
          pkgs = buildPlatformPkgs;
          targetPkgs = buildPlatformPkgs.pkgsStatic;
        }) // {
          default = self.packages.x86_64-linux.all-deb;
        };

        aarch64-linux = (builder {
          pkgs = buildPlatformPkgs;
          targetPkgs = buildPlatformPkgs.pkgsCross.aarch64-multiplatform-musl;
        }) // {
          default = self.packages.aarch64-linux.all-deb;
        };

        all = {
          all-deb = with buildPlatformPkgs; (import ./toolbox/all-deb.nix) {
            inherit lib stdenv;
            debs = {
              x86_64-linux = self.packages.x86_64-linux.all-deb;
              aarch64-linux = self.packages.aarch64-linux.all-deb;
            };
          };
          default = self.packages.all.all-deb;
        };
      };
  };

  nixConfig = {
    extra-substituters = "https://cache.garnix.io/";
    extra-trusted-public-keys = "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
  };
}
