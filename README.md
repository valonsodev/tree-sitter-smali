# tree-sitter-smali

Opinionated and pdated Smali grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).
- Less strict than the official one allowing allowing parsing of smali snippets.
- Allows full unicode in identifiers and string literals.
This repository is based on the original
[`tree-sitter-grammars/tree-sitter-smali`](https://github.com/tree-sitter-grammars/tree-sitter-smali) grammar by Yotam Nachum and Amaan Qureshi.

Published package names include the `valonsodev` suffix to avoid conflicting
with the original upstream package names:

- Cargo: `tree-sitter-smali-valonsodev`
- npm: `tree-sitter-smali-valonsodev`
- PyPI: `tree-sitter-smali-valonsodev`

The Smali syntax is not especially well documented, so the authoritative source
for syntax details remains the upstream Smali project, especially
[`smaliLexer.jflex`](https://github.com/JesusFreke/smali/blob/master/smali/src/main/jflex/smaliLexer.jflex).
