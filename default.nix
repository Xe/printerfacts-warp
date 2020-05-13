{ system ? builtins.currentSystem }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  printerfacts = import ./printerfacts.nix { inherit pkgs sources; };

  name = "xena/printerfacts";
  tag = "latest";

in pkgs.dockerTools.buildLayeredImage {
  inherit name tag;
  contents = [ printerfacts ];

  config = {
    Cmd = [ "/bin/printerfacts" ];
    WorkingDir = "/";
  };
}
