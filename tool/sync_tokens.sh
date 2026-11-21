#!/usr/bin/env bash
# Regenerates lib/core/theme/app_tokens.dart from the design system's generated
# Flutter tokens, applying the transforms this app needs. Never hand-edit
# app_tokens.dart; change the design source (tokens.json) and re-run this.
#
# Usage: tool/sync_tokens.sh <path to design/flutter/*_tokens.dart> [output]
#
# Transforms:
#   1. material_ui import (Flutter 3.50 deprecated flutter/material.dart)
#   2. product-name prefix -> neutral `App` prefix (AppColors, AppSpace, ...)
#   3. `context.<brand>` accessor -> `context.tokens`
#   4. product name in comments -> "the app"
# The product name is undecided, so it must not appear in code (see AGENTS.md).
set -euo pipefail

src="${1:?usage: tool/sync_tokens.sh <design tokens .dart> [output]}"
out="${2:-lib/core/theme/app_tokens.dart}"
brand="${BRAND_PREFIX:-Grov}"           # the prefix used by the design generator
lower="$(printf '%s' "$brand" | tr '[:upper:]' '[:lower:]')"

perl -pe "
  s#package:flutter/material.dart#package:material_ui/material_ui.dart#;
  s/\\b${brand}([A-Z][A-Za-z]*)/App\$1/g;
  s/\\bget ${lower}\\b/get tokens/g;
  s/(^|\\/\\/\\/? |[.!?] )${brand}\\b/\$1The app/g;
  s/\\b${brand}\\b/the app/g;
" "$src" > "$out"
dart format "$out" >/dev/null
echo "wrote $out"
