{ pkgs }:

let
  build-debs = pkgs.writeShellApplication {
    name = "build-debs";
    runtimeInputs = [ ];
    text = ''nix build -L .#packages.all.all-deb'';
  };

  repo-add = pkgs.writeShellApplication {
    name = "repo-add";
    runtimeInputs = [ pkgs.aptly ];
    text = ''
      build-debs
      aptly repo add -force-replace all result/*
    '';
  };

  repo-publish = pkgs.writeShellApplication {
    name = "repo-publish";
    runtimeInputs = [ pkgs.aptly ];
    text = ''aptly publish update -force-overwrite all s3:noql-apt:all'';
  };
in pkgs.mkShell {
  buildInputs = [
    pkgs.aptly
    build-debs
    repo-add
    repo-publish
  ];
}
