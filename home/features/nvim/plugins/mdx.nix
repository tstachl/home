{
  filetype.extension.mdx = "mdx";

  plugins.treesitter.languageRegister.markdown = "mdx";

  extraFiles = {
    # highlighting import statements in markdown
    "queries/markdown/injections.scm".text = ''
      ; extends
      ((inline) @injection.content
        (#lua-match? @injection.content "^%s*import")
        (#set! injection.language "typescript"))
      ((inline) @injection.content
        (#lua-match? @injection.content "^%s*export")
        (#set! injection.language "typescript"))
    '';

    # disable spell check if turned on
    "queries/markdown/highlights.scm".text = ''
      ; extends
      ((inline) @_inline (#lua-match? @_inline "^%s*import")) @nospell
      ((inline) @_inline (#lua-match? @_inline "^%s*export")) @nospell
    '';
  };
}
