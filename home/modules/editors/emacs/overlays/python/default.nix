final: prev:
{
  tree-sitter-grammars = prev.tree-sitter-grammars // {
    tree-sitter-python = prev.tree-sitter-grammars.tree-sitter-python.overrideAttrs (_: {
      nativeBuildInputs = [ final.nodejs final.tree-sitter ];
      configurePhase = ''
        tree-sitter generate --abi 13 src/grammar.json
      '';
    });
  };
}
