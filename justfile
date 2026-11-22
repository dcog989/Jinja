# --- just conventions ---------------------------------------------------------------
# - One runner per repo: no Makefile; scripts stay in package.json/Cargo.toml; CI calls `just`, never the tool underneath.
# - Same recipe names everywhere; add a recipe instead of typing the raw tool.
# - Stages exist where the project has them; a missing stage is exempt, lint and format never.
# - `install` is the only `sudo` recipe. Optional: dev, run, package, clean, update, release.
# - check mirrors CI, lockfiles included (`cargo test --locked`, `bun install --frozen-lockfile`); jobs may narrow it to `just lint` / `just test`.
# - Forwarding recipes are one body line, never the script body; cross-directory work lives here, not in a `package.json` script that `cd`s away.
# - Recipes hold only unguessable knowledge: flags, ordering, env vars, install prefixes, tool versions; not a `cargo build` alias.
# - POSIX `sh` unless fish is needed; no secrets, no network in `check`, no system mutation outside `install`.
# - Hooks pass file lists to `*-staged` and argument recipes.
# - Edit this header in `~/Projects/.scaffold/template/_lang_root/*/justfile.jinja` first, then the repos.
# --- end just conventions -----------------------------------------------------------

# Verify the project: lint, format check and tests.
default: check

# Lint, format check and tests.
check: rev-check lint format-check test

# Require the tree-sitter version used to generate the parser.
_ts-cli:
    @test "$(tree-sitter --version)" = "tree-sitter 0.26.9" || { echo "tree-sitter 0.26.9 required"; exit 1; }

# Fail if extension.toml pins a grammar revision older than HEAD.
rev-check:
    test "$(git rev-parse "$(sed -n 's/^rev = "\(.*\)"/\1/p' extension.toml):grammar/src")" = "$(git rev-parse HEAD:grammar/src)"

# Validate the grammar queries and the bracket pairing fixture.
lint: _ts-cli
    cd grammar && tree-sitter query ../languages/jinja/highlights.scm ../test.jinja | grep -q 'capture:'
    cd grammar && tree-sitter query ../languages/jinja/brackets.scm ../test.jinja | grep -q 'capture:'
    cd grammar && tree-sitter query ../languages/jinja/outline.scm ../test.jinja | grep -q 'text: `a, b`'
    cd grammar && test "$(tree-sitter query ../languages/jinja/brackets.scm test/queries/brackets.jinja | grep -c 'capture:')" -eq 10

# Regenerate the parser, node types and grammar JSON.
format: _ts-cli
    cd grammar && tree-sitter generate

# Fail if generated sources are out of date.
format-check: _ts-cli
    cd grammar && tree-sitter generate
    test -z "$(git status --porcelain -- grammar/src)"

# Test suite.
test: _ts-cli
    cd grammar && tree-sitter test
    cd grammar && tree-sitter parse -q ../test.jinja

# Regenerate the grammar parser.
build: _ts-cli
    cd grammar && tree-sitter generate
