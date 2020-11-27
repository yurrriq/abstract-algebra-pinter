self: super: {
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
      xfor
      ;
  };
}
