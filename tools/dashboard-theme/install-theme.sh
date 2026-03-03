#!/bin/bash
# Install Alchemix theme for OpenClaw Control UI dashboard
# Re-run after `openclaw update` to preserve the theme
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_CSS="$SCRIPT_DIR/alchemix-theme.css"

# Find OpenClaw control-ui install directory
OC_INSTALL=""
for candidate in \
  "$HOME/.npm-global/lib/node_modules/openclaw/dist/control-ui" \
  "/usr/local/lib/node_modules/openclaw/dist/control-ui" \
  "$(npm root -g 2>/dev/null)/openclaw/dist/control-ui"; do
  if [ -d "$candidate" ]; then
    OC_INSTALL="$candidate"
    break
  fi
done

if [ -z "$OC_INSTALL" ]; then
  echo "❌ Could not find OpenClaw install directory."
  echo "   Make sure openclaw is installed: npm install -g openclaw"
  exit 1
fi

DEST="$HOME/.openclaw/control-ui"
mkdir -p "$DEST/assets"

echo "🎨 Installing Alchemix dashboard theme..."

# Copy base control-ui assets from OpenClaw install
rsync -a --exclude='alchemix-theme.css' "$OC_INSTALL/" "$DEST/"
echo "  ✓ Synced base assets from $OC_INSTALL"

# Copy theme CSS
cp "$THEME_CSS" "$DEST/assets/alchemix-theme.css"
echo "  ✓ Copied alchemix-theme.css"

# Inject theme link into index.html
if ! grep -q 'alchemix-theme.css' "$DEST/index.html"; then
  sed -i '' 's|</head>|    <link rel="stylesheet" href="./assets/alchemix-theme.css">\n  </head>|' "$DEST/index.html"
  echo "  ✓ Injected theme link into index.html"
else
  echo "  ✓ Theme link already present"
fi

echo ""
echo "✅ Theme installed to $DEST"
echo ""
echo "To activate, add to your openclaw config:"
echo '  "gateway": { "controlUi": { "root": "~/.openclaw/control-ui" } }'
echo ""
echo "Then: openclaw gateway restart"
echo ""
echo "⚠️  After every 'openclaw update', re-run this script to preserve the theme."
