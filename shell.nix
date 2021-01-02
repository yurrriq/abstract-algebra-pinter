{ pkgs ? import ./nix }:

let
  project = import ./default.nix { inherit pkgs; };
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake
    haskellPackages.ormolu
    nixpkgs-fmt
    pythonPackages.pywatchman
    # TODO: sagemath
    xelatex
  ] ++ (import ./haskell.nix { inherit pkgs; }).env.nativeBuildInputs;
}
