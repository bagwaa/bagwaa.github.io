#!/usr/bin/env bash
# Regenerate Richard_Bagshaw_CV.pdf from index.html using headless Chrome.
# Usage: ./build-pdf.sh

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT="$DIR/index.html"
OUTPUT="$DIR/Richard_Bagshaw_CV.pdf"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [[ ! -x "$CHROME" ]]; then
  echo "Could not find Google Chrome at: $CHROME" >&2
  exit 1
fi

if [[ ! -f "$INPUT" ]]; then
  echo "Missing input HTML: $INPUT" >&2
  exit 1
fi

"$CHROME" \
  --headless=new \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --print-to-pdf="$OUTPUT" \
  "file://$INPUT" 2>/dev/null

echo "Built: $OUTPUT"
