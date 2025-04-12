{
  description = "debs";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.oven.url = "github:noql-net/oven?rev=9531e07b59bd3fd60711f5e743f0e74b6ba4c8a5";

  outputs = { self, nixpkgs, oven }: rec {
    devShells.x86_64-linux.default = ((import ./toolbox/shell.nix) { pkgs = nixpkgs.legacyPackages.x86_64-linux; });
    packages =
      let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        builder = import ./packages.nix;
      in
      {
        x86_64-linux =
          (builder { inherit lib pkgs; oven = oven.packages.x86_64-linux; }) //
          { default = packages.x86_64-linux.all-deb; };

        aarch64-linux =
          (builder { inherit lib pkgs; oven = oven.packages.aarch64-linux; }) //
          { default = packages.aarch64-linux.all-deb; };

        all = {
          all-deb = with pkgs;
            (import ./toolbox/all-deb.nix) {
              inherit lib stdenv;
              debs = with packages; {
                x86_64-linux = x86_64-linux.all-deb;
                aarch64-linux = aarch64-linux.all-deb;
              };
            };
          default = packages.all.all-deb;
        };
      };
  };

  nixConfig = {
    extra-substituters = "https://cache.garnix.io/";
    extra-trusted-public-keys = "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
  };
}
