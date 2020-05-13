let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };
  dhall = import <dhall> { };
in pkgs.mkShell {
  buildInputs = with pkgs; [
    rustc
    cargo
    cargo-watch
    rls
    rustfmt

    dhall.linux-dhall
    dhall.linux-dhall-yaml
  ];

  RUST_LOG = "info";
}
