#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_DIR="$ROOT_DIR"
DERIVED_DATA="${DERIVED_DATA:-/tmp/YogaFlowVisualQA}"
DEVICE_ID="${DEVICE_ID:-booted}"
OUT_DIR="${OUT_DIR:-$ROOT_DIR/visual-qa-shots}"
SCREENS=(splash goal level plan home detail profile)

mkdir -p "$OUT_DIR"

if [[ "$DEVICE_ID" != "booted" ]]; then
  xcrun simctl boot "$DEVICE_ID" >/dev/null 2>&1 || true
  xcrun simctl bootstatus "$DEVICE_ID" -b
fi

xcodebuild \
  -project "$PROJECT_DIR/YogaFlow.xcodeproj" \
  -scheme YogaFlow \
  -destination "generic/platform=iOS Simulator" \
  -derivedDataPath "$DERIVED_DATA" \
  build

xcrun simctl install "$DEVICE_ID" "$DERIVED_DATA/Build/Products/Debug-iphonesimulator/YogaFlow.app"

for screen in "${SCREENS[@]}"; do
  xcrun simctl terminate "$DEVICE_ID" vn.cyme.YogaFlow >/dev/null 2>&1 || true
  xcrun simctl launch "$DEVICE_ID" vn.cyme.YogaFlow -YogaFlowScreen "$screen" >/dev/null
  sleep 1
  perl -e 'alarm shift; exec @ARGV' 15 xcrun simctl io "$DEVICE_ID" screenshot "$OUT_DIR/$screen.png"
done

echo "Saved screenshots to $OUT_DIR"
