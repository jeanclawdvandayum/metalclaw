#!/bin/bash
# metalclaw installer — skills + memory system upgrades
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_DIR/skills"
SYSTEM_DIR="$REPO_DIR/system"

OC_DIR="${HOME}/.openclaw/skills"
CC_DIR="${HOME}/.claude/skills"
WORKSPACE="${CLAWD_WORKSPACE:-$(pwd)}"

echo "🤘 metalclaw installer"
echo "======================"
echo ""
echo "Workspace: $WORKSPACE"
echo ""

# ── Skills ──
mkdir -p "$OC_DIR" "$CC_DIR"
SKILL_COUNT=$(ls -d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')
echo "Installing $SKILL_COUNT skills..."

INSTALLED=0
for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_dir")
  mkdir -p "$OC_DIR/$skill_name" "$CC_DIR/$skill_name"
  cp -r "$skill_dir"* "$OC_DIR/$skill_name/" 2>/dev/null || true
  cp -r "$skill_dir"* "$CC_DIR/$skill_name/" 2>/dev/null || true
  INSTALLED=$((INSTALLED + 1))
  echo "  ✅ $skill_name"
done

echo ""
echo "Installed $INSTALLED skills to:"
echo "  → $OC_DIR"
echo "  → $CC_DIR"

# ── Memory System ──
echo ""
echo "Installing memory system..."

# Only copy system files that DON'T already exist (don't overwrite user's work)
for f in AGENTS.md COMMANDS.md LESSONS.md HOLDS.md FRICTION.md PREDICTIONS.md; do
  src="$SYSTEM_DIR/$f"
  dst="$WORKSPACE/$f"
  if [ -f "$src" ]; then
    if [ -f "$dst" ]; then
      echo "  ⏭️  $f (exists, skipping)"
    else
      cp "$src" "$dst"
      echo "  ✅ $f"
    fi
  fi
done

# Create memory directory structure
mkdir -p "$WORKSPACE/memory/topics"
if [ ! -f "$WORKSPACE/memory/_index.md" ]; then
  cp "$SYSTEM_DIR/memory/_index.md" "$WORKSPACE/memory/_index.md"
  echo "  ✅ memory/_index.md"
else
  echo "  ⏭️  memory/_index.md (exists, skipping)"
fi

# ── Reference Material ──
REF_DIR="$REPO_DIR/reference"
if [ -d "$REF_DIR" ] && [ "$(ls -A "$REF_DIR" 2>/dev/null)" ]; then
  mkdir -p "$WORKSPACE/reference"
  cp "$REF_DIR"/*.md "$WORKSPACE/reference/" 2>/dev/null || true
  echo ""
  echo "📚 Reference docs copied to $WORKSPACE/reference/"
fi

# ── Tools ──
TOOLS_DIR="$REPO_DIR/tools"
if [ -d "$TOOLS_DIR" ]; then
  mkdir -p "$WORKSPACE/tools/security"
  cp "$TOOLS_DIR"/*.md "$WORKSPACE/tools/" 2>/dev/null || true
  cp -r "$TOOLS_DIR/security/" "$WORKSPACE/tools/security/" 2>/dev/null || true
  echo "🔧 Tool guides + scripts copied to $WORKSPACE/tools/"
fi

echo ""
echo "🤘 Done."
echo ""
echo "Next steps:"
echo "  1. Create your SOUL.md (who is the agent?)"
echo "  2. Create your USER.md (who are you?)"
echo "  3. Restart gateway: openclaw gateway restart"
echo ""
echo "Optional tool installs:"
echo "  bash scripts/install-scrapling.sh   # Stealth web scraper"
echo "  brew install whisper-cpp            # Local speech-to-text"
echo "  npm install beautiful-mermaid tsx   # ASCII/SVG diagrams"
echo "  npm install @paper-design/shaders  # Canvas visual effects"
echo ""
echo "Memory system files installed:"
echo "  AGENTS.md      — Session startup, group chat rules, heartbeats, sub-agent gates"
echo "  COMMANDS.md    — 18 vault commands (/today, /map, /graduate, etc.)"
echo "  LESSONS.md     — Mistake → guardrail pipeline"
echo "  HOLDS.md       — Temporary context filters"
echo "  FRICTION.md    — Contradiction log"
echo "  PREDICTIONS.md — Decision calibration"
echo "  memory/_index.md  — Knowledge graph entry point"
echo "  memory/topics/    — Atomic topic files (create as you go)"
echo ""
echo "Tools installed:"
echo "  tools/security/scan-injection.py — Prompt injection scanner"
echo "  tools/*.md — Usage guides for scrapling, mermaid, whisper, shaders, here.now"
