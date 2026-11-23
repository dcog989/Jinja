# Agent Directives

## Project Specifics

- Name: jinja
- Description: Zed extension for Jinja syntax highlighting, indentation, bracket matching and outline, aimed at project scaffolding templates.
- Tech: Tree-sitter grammar (JavaScript DSL, C external scanner), Zed extension toml, Tree-sitter queries in Scheme.

### Key Files

- `extension.toml` — extension metadata and grammar revision pin
- `languages/jinja/config.toml` — language settings, indentation and block comment
- `languages/jinja/highlights.scm` — highlighting query
- `languages/jinja/brackets.scm` — bracket pairs
- `languages/jinja/outline.scm` — outline symbols
- `grammar/grammar.js` — grammar source, a patched fork of `bennypowers/tree-sitter-jinja-dialects`; keep the upstream MIT notice in `grammar/LICENSE`
- `grammar/src/` — generated parser, node types and grammar JSON
- `grammar/src/scanner.c` — hand-written external scanner, not generated
- `grammar/test/corpus/` — grammar tests
- `grammar/test/queries/brackets.jinja` — bracket fixture, must yield 10 captures
- `test.jinja` — fixture for every supported construct

### Workflow

- Test: `just test` (tree-sitter-cli 0.27.2; the justfile rejects any other version)
- Full gate: `just check` — rev pin, query lint, generated sources current, tests
- Lint queries: `just lint` (only check on the `.scm` files)
- Rebuild grammar: `just build`, then commit the regenerated `grammar/src/`
- Install locally: run `zed: install dev extension` and point at this directory
- After any grammar change, bump `rev` in `extension.toml` to the commit containing it

### Tools

- File tools (glob, grep, read, write, edit, shell) are called directly, never as `tools.*` inside execute. execute exposes only `browser.*`, `opencode.*`, and search() results.

### Common Patterns

- Add syntax: edit `grammar/grammar.js`, run `just build`, add a corpus case, run `just test`
- Add highlight: edit `languages/jinja/highlights.scm`
- Add fixture: extend `test.jinja` and keep `just test` passing

### File System Access

- Allowed: this repository and all contained directories + files; `/tmp/*`
- Read-Only: `.env*`, `.git/`, `~/Pictures/Screenshots/`
- Disallowed: everything not listed in 'Allowed' unless user grants permission.
- Require confirmation: adding/removing dependencies, any operation outside project root
- Do not delete files or make destructive changes without permission / confirmation.

### Verification

- Do not run test, lint, format, or type-check commands unless the user explicitly asks.

---

## General Guidelines

### Code Changes

- For non-trivial work, propose an approach and confirm before implementing, including architectural changes.
- Keep modifications minimal and scoped; prefer incremental improvements over rewrites.
- Use explicit types and named constants (no magic numbers).
- Return explicit error types; do not suppress exceptions.
- Follow standard repository linting and formatting configs.
- Decompose files over 400 lines if they mix concerns.
- Name things clearly; reserve comments for the non-obvious why (workarounds, edge cases).
- Never run git mutations (commit, push, reset, rebase, amend) unless explicitly instructed.
- Do not create documentation files unless explicitly requested.
- Adhere to <https://develop.kde.org/hig/>.
- Use APCA rather than WCAG for color contrast.

### Author Environment

- Ryzen 5800X3D, Radeon RX 7900 XT, Display (AW3225QF); CachyOS, KDE, KWin / Wayland, Btrfs.
- fish shell, Ghostty terminal, Fresh TUI editor, yay package manager, bun npm manager, Firefox, Zed code editor.

### Testing

- Add tests only when the logic is genuinely testable and worth guarding. No test files for trivial changes or behavior the environment cannot test reliably (e.g. UI layout/click mapping).

### Definition of Done

- Logic fully implemented.
- Existing docs updated if public interfaces changed.
- Run the corresponding `Workflow` command when `Verification` requires it.

### Commit Messages

- On completion of an update or fix, print a conventional commit message in a fenced code block.
- Add a body only when the "why" isn't obvious.
- Never hard-wrap: one physical line per paragraph, however long.

### Communication Style

- Short declarative sentences, one idea per line.
- Instructions: numbered steps, one action each (exact command, path, or code); no prose recap.
- Explanations: essential context only. End question answers with `TL;DR:`, one sentence; omit for status updates and completed work.
- Tone: no preamble, restating, hedging, disclaimers, emotional framing, or closing offers.
- Ask when requirements are ambiguous.
- Answer only what was asked; omit skipped items, asides, and optional suggestions unless requested.
- Do not append a "skipped / risk" footer.
