#!/bin/bash
# Install scrapling web scraper — stealth fetcher with Cloudflare bypass
set -e

echo "🕷️ Installing scrapling..."
echo ""

# Check for pipx
if ! command -v pipx &> /dev/null; then
  echo "pipx not found. Installing via pip..."
  pip install --user pipx
  pipx ensurepath
fi

# Install scrapling with all extras
pipx install 'scrapling[all]'

# Install Playwright browsers (needed for JS rendering + stealth mode)
echo ""
echo "Installing Playwright browsers..."
PIPX_VENV="$HOME/.local/pipx/venvs/scrapling"
if [ -d "$PIPX_VENV" ]; then
  "$PIPX_VENV/bin/python" -m playwright install chromium
else
  echo "⚠️  Could not find scrapling venv. Run manually:"
  echo "    python -m playwright install chromium"
fi

# Install camoufox for stealth mode
echo ""
echo "Installing camoufox (stealth browser)..."
"$PIPX_VENV/bin/python" -c "import camoufox; camoufox.install()" 2>/dev/null || true

echo ""
echo "✅ scrapling installed!"
echo ""
echo "Usage (from your agent):"
echo "  # Fast HTTP fetch (impersonates Chrome TLS)"
echo "  python3 -c \"from scrapling.fetchers import Fetcher; print(Fetcher.get('https://example.com').text[:500])\""
echo ""
echo "  # JS-rendered pages (Playwright)"
echo "  python3 -c \"from scrapling.fetchers import DynamicFetcher; print(DynamicFetcher.get('https://example.com').text[:500])\""
echo ""
echo "  # Cloudflare bypass (stealth mode)"
echo "  python3 -c \"from scrapling.fetchers import StealthyFetcher; print(StealthyFetcher.get('https://example.com').text[:500])\""
