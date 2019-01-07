let

  fetchTarballFromGitHub =
    { owner, repo, rev, sha256, ... }:
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/tarball/${rev}";
      inherit sha256;
    };

  fromJSONFile = f: builtins.fromJSON (builtins.readFile f);

in

{ nixpkgs ? fetchTarballFromGitHub (fromJSONFile ./nixpkgs-src.json) }:

with import nixpkgs {
  overlays = [
    (self: super: {
      xelatex = super.texlive.combine {
        inherit (super.texlive) scheme-small
          braket
          datatool
          # ebproof
          enumitem
          glossaries
          hardwrap
          latexmk
          mfirstuc
          substr
          titlesec
          # tkz-base
          # tkz-berge
          # tkz-graph
          todonotes
          tufte-latex
          xetex
          xindy
          xfor;
      };
    })
  ];
};

{

  drv = stdenv.mkDerivation rec {
    name = "abstract-algebra-pinter-${version}";
    version = "0.1.0";
    src = ./.;

    buildInputs = [
      xelatex
    ];

    installPhase = ''
      install -Dm755 src/exercises.pdf "$out/exercises.pdf"
    '';

    meta = with stdenv.lib; {
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
  };

  shell = mkShell {
    buildInputs = [
      gnumake
      xelatex
    ];
  };

}
