{
  description = "debrepo";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";

  outputs = { self, nixpkgs }: {
    packages =
      let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        builder = import ./packages;
      in
      {
        x86_64-linux =
          (builder { inherit lib pkgs; targetPkgs = pkgs.pkgsStatic; }) //
          { default = self.packages.x86_64-linux.all-deb; };

        aarch64-linux =
          (builder { inherit lib pkgs; targetPkgs = pkgs.pkgsCross.aarch64-multiplatform-musl; }) //
          { default = self.packages.aarch64-linux.all-deb; };

        all = {
          all-deb = with pkgs;
            (import ./toolbox/all-deb.nix) {
              inherit lib stdenv;
              debs = with self.packages; {
                x86_64-linux = x86_64-linux.all-deb;
                aarch64-linux = aarch64-linux.all-deb;
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
