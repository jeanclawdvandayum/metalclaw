#!/bin/bash
# metalclaw installer — copies skills to OpenClaw and Claude Code skill directories
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_DIR/skills"

OC_DIR="${HOME}/.openclaw/skills"
CC_DIR="${HOME}/.claude/skills"

echo "🤘 metalclaw installer"
echo "======================"
echo ""

# Create target directories
mkdir -p "$OC_DIR" "$CC_DIR"

# Count skills
SKILL_COUNT=$(ls -d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')
echo "Found $SKILL_COUNT skills to install."
echo ""

# Install each skill
INSTALLED=0
for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_dir")
  
  # Copy to OpenClaw
  mkdir -p "$OC_DIR/$skill_name"
  cp -r "$skill_dir"* "$OC_DIR/$skill_name/" 2>/dev/null || true
  
  # Copy to Claude Code
  mkdir -p "$CC_DIR/$skill_name"
  cp -r "$skill_dir"* "$CC_DIR/$skill_name/" 2>/dev/null || true
  
  INSTALLED=$((INSTALLED + 1))
  echo "  ✅ $skill_name"
done

echo ""
echo "Installed $INSTALLED skills to:"
echo "  → $OC_DIR"
echo "  → $CC_DIR"
echo ""

# Copy reference material
REF_DIR="$REPO_DIR/reference"
if [ -d "$REF_DIR" ]; then
  WORKSPACE="${CLAWD_WORKSPACE:-$HOME/clawd}"
  mkdir -p "$WORKSPACE/reference"
  cp "$REF_DIR"/*.md "$WORKSPACE/reference/" 2>/dev/null || true
  echo "📚 V3 reference docs copied to $WORKSPACE/reference/"
fi

echo ""
echo "🤘 Done. Restart your OpenClaw gateway to pick up new skills."
echo ""
echo "Pro tip: Run 'openclaw gateway restart' or your agent can do it."
