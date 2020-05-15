{ sources ? import ./nix/sources.nix, pkgs ? import <nixpkgs> { } }:
let
  srcNoTarget = dir:
    builtins.filterSource
    (path: type: type != "directory" || builtins.baseNameOf path != "target")
    dir;
  naersk = pkgs.callPackage sources.naersk { };
  src = srcNoTarget ./.;
  pfacts = naersk.buildPackage {
    inherit src;
    remapPathPrefix = true;
  };
in pfacts
