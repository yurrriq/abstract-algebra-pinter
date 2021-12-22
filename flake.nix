{
  description = ''Exercises from "A Book of Abstract Algebra"'';

  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.11";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          self.overlay
        ];
      };
      src = pkgs.nix-gitignore.gitignoreSource [ ".git/" ] ./.;
    in
    {
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          coreutils
          gitAndTools.pre-commit
          gnumake
          haskellPackages.ormolu
          moreutils
          nixpkgs-fmt
          pythonPackages.pywatchman
          # TODO: sagemath
          semver-tool
          xelatex
        ] ++ self.packages.x86_64-linux.pinter.env.nativeBuildInputs;
      };


      overlay = final: prev: {
        xelatex = prev.texlive.combine {
          inherit (prev.texlive) scheme-small
            amsrefs
            braket
            catchfile
            datatool
            datetime
            ebproof
            enumitem
            glossaries
            glossaries-extra
            hyperref
            latexmk
            mfirstuc
            rsfs
            tikz-cd
            tkz-base
            # tkz-berge
            # tkz-graph
            todonotes
            tracklang
            xetex
            xfor
            xindy
            xstring
            ;
        };
      };

      packages.x86_64-linux = {
        abstract-algebra-pinter =
          pkgs.stdenv.mkDerivation rec {
            pname = "abstract-algebra-pinter";
            version = builtins.readFile ./VERSION;
            inherit src;

            nativeBuildInputs = with pkgs; [
              xelatex
            ];

            makeFlags = [
              "PREFIX=${placeholder "out"}"
            ];

            meta = with pkgs.lib; {
              description = ''Exercises from "A Book of Abstract Algebra"'';
              longDescription = ''
                Working through exercises in "A Book of Abstract Algebra"
                by Charles C. Pinter.
              '';
              homepage = "https://github.com/yurrriq/abstract-algebra-pinter";
              license = licenses.unlicense;
              maintainers = with maintainers; [ yurrriq ];
              platforms = platforms.all;
            };
          };
        pinter = pkgs.haskellPackages.callCabal2nix "pinter" src { };
      };

      defaultPackage.x86_64-linux = self.packages.x86_64-linux.abstract-algebra-pinter;
    };
}
