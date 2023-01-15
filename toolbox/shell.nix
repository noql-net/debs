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

  readme-update = pkgs.writeShellApplication {
    name = "readme-update";
    runtimeInputs = [ pkgs.gomplate ];
    text = ''
      nix eval --json '.#packages.x86_64-linux' --apply builtins.attrNames | \
      jq 'map(select(.|test("(deb|default)$")|not))' | \
      gomplate --datasource pkgs=stdin:///pkgs.json --file readme.tmpl --out README.md
    '';
  };
in pkgs.mkShell {
  buildInputs = [
    pkgs.aptly
    pkgs.gomplate

    build-debs
    repo-add
    repo-publish
    readme-update
  ];
}
