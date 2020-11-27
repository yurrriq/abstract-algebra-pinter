{ pkgs ? import ./nix }:

let
  project = import ./default.nix { inherit pkgs; };
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake
    nixpkgs-fmt
    pythonPackages.pywatchman
    xelatex
  ];
}
