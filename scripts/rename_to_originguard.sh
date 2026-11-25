#!/usr/bin/env bash
# Rename AgentGuard -> OriginGuard across the repo (package, imports, env vars, docs, deploy files).
# Run from anywhere inside the repo:  bash scripts/rename_to_originguard.sh
# Safe to re-run. Does NOT touch .env, .git, docs/research/, or this script.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

mv_cmd() { if git ls-files --error-unmatch "$1" >/dev/null 2>&1; then git mv "$1" "$2"; else mv "$1" "$2"; fi; }

[ -d agentguard ] && mv_cmd agentguard originguard
[ -f deploy/k8s/agentguard.yaml ] && mv_cmd deploy/k8s/agentguard.yaml deploy/k8s/originguard.yaml

FILES=$(git ls-files -z --cached --others --exclude-standard \
  | tr '\0' '\n' \
  | grep -v -E '^(\.env|docs/research/|scripts/rename_to_originguard\.sh$|.*\.(pdf|png|jpg|xlsx|zip)$)' \
  | while read -r f; do [ -f "$f" ] && grep -Iq . "$f" 2>/dev/null && echo "$f"; done)

echo "$FILES" | while read -r f; do
  [ -z "$f" ] && continue
  sed -i \
    -e 's/agentguard-fw/originguard/g' \
    -e 's/AGENTGUARD/ORIGINGUARD/g' \
    -e 's/AgentGuard/OriginGuard/g' \
    -e 's/agentguard/originguard/g' "$f"
done

# Keep a visible record of the old name in the README (once).
if [ -f README.md ] && ! grep -q "formerly AgentGuard" README.md; then
  python3 - <<'PY'
import re
p="README.md"; s=open(p,encoding="utf-8").read()
note=("> **OriginGuard** (formerly AgentGuard). Renamed because four unrelated arXiv papers already use "
      "\"AgentGuard\" (2502.09809, 2509.23864, 2605.28071, 2609.16287). See docs/research/README.md.\n\n")
m=re.search(r"^# .*\n+",s,re.M)
s=(s[:m.end()]+note+s[m.end():]) if m else note+s
open(p,"w",encoding="utf-8").write(s)
PY
fi

echo "Done. Next:"
echo "  1. Update your local .env: rename AGENTGUARD_* variables to ORIGINGUARD_* (script does not touch .env)."
echo "  2. pytest -q"
echo "  3. git add -A && git commit -m 'Rename AgentGuard to OriginGuard'"
echo "  4. GitHub: Settings > General > Repository name -> originguard ; then: git remote set-url origin <new url>"
echo "  5. Vercel: rename project / update env vars to ORIGINGUARD_*; redeploy."
echo "  6. Optionally rename the local folder: mv ../agentguard-fw ../originguard"
