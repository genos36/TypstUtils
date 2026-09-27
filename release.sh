#!/usr/bin/env bash
# Uso: ./release.sh 0.1.0
# Aggiorna typst.toml, fa commit e tag, espone la versione come package @local.
set -euo pipefail

V="${1:?uso: ./release.sh <versione>, es. 0.1.0}"
DEST="$HOME/.local/share/typst/packages/local/typst-utils/$V"

[[ "$V" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "versione non valida: $V"; exit 1; }
[[ -z "$(git status --porcelain)" ]] || { echo "ci sono modifiche non committate"; exit 1; }
git rev-parse -q --verify "refs/tags/v$V" >/dev/null && { echo "il tag v$V esiste già"; exit 1; }
[[ -e "$DEST" ]] && { echo "$DEST esiste già"; exit 1; }
grep -q "## \[$V\]" CHANGELOG.md || { echo "manca la sezione [$V] in CHANGELOG.md"; exit 1; }

typst compile --root . examples/demo.typ /tmp/typst-utils-demo.pdf

sed -i "s/^version = .*/version = \"$V\"/" typst.toml
git diff --quiet || git commit -am "release $V"
git tag "v$V"
git worktree add "$DEST" "v$V"

echo "rilasciata $V → $DEST"
echo "ricordati: git push && git push --tags"