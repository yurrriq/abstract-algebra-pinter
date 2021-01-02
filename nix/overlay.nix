self: super: {
  xelatex = super.texlive.combine {
    inherit (super.texlive) scheme-small
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
      tkz-base
      # tkz-berge
      # tkz-graph
      todonotes
      tracklang
      xetex
      xindy
      xfor
      xstring
      ;
  };
}
