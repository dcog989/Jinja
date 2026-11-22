# README: jinja

Zed extension for Jinja syntax highlighting, indentation, bracket matching and outline. Specifically for use with project scaffolding templates, such as [Copier](https://github.com/copier-org/copier).

The extension follows <https://jinja.palletsprojects.com/en/stable/> and associates `.jinja`, `.jinja2`, `.j2` filetypes.

> [!NOTE]
> If the use case is HTML templates then install `Jinja2 Template Support` or `HTML-Jinja Template Support`.

## Installation

This extension is not published to the gallery yet. Install it as a dev extension: run `zed: install dev extension` and point at this directory.

The grammar is pinned to a local `file://` path in `extension.toml`, so the install only works at this directory. Before publishing, replace `repository` with the public URL and bump `rev`.

## Known limitations

- Line statements and custom delimiters are not supported.
- `{% trans %}` is not parsed as a block; its tags highlight as generic tags.

## Development

`just test` runs the grammar corpus and checks that `test.jinja` parses without errors. Development needs `tree-sitter-cli` 0.26.11.

The grammar source is a patched copy of <https://github.com/bennypowers/tree-sitter-jinja-dialects>, in `grammar/`. The patch adds test arguments, slices, bare and empty tuples, filter chains, and `+` whitespace control.

After editing the grammar, run `just build`, commit, and bump `rev` in `extension.toml` to the commit containing the change. `just check` fails while the pin lags `HEAD`.

## License

[MIT License](LICENSE).
