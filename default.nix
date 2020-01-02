{
  pkgs ? import ./nix/nixpkgs.nix {},
  src ? pkgs.nix-gitignore.gitignoreSource [ ".git/" ] ./.
}:

pkgs.stdenv.mkDerivation rec {
  pname = "abstract-algebra-pinter";
  version = builtins.readFile ./VERSION;
  inherit src;

  buildInputs = [
    pkgs.xelatex
  ];

  installPhase = ''
    install -Dm755 src/exercises.pdf "$out/exercises.pdf"
  '';

  meta = with pkgs.stdenv.lib; {
    description = "Exercises from 'A Book of Abstract Algebra'";
    longDescription = ''
      Working through exercises in "A Book of Abstract Algebra"
      by Charles C. Pinter.
    '';
    homepage = https://github.com/yurrriq/abstract-algebra-pinter;
    license = licenses.unlicense;
    maintainers = with maintainers; [ yurrriq ];
    platforms = platforms.all;
  };
}
