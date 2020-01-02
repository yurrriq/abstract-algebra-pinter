{ pkgs ? import ./nix/nixpkgs.nix {} }:

let
  project = import ./default.nix { inherit pkgs; };
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake
    nix-prefetch-git
    xelatex
  ];
}
