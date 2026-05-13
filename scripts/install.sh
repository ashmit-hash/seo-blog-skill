#!/bin/bash

echo ""
echo "========================================"
echo "  SEO Blog Skill Installer (Mac/Linux)"
echo "========================================"
echo ""

# Detect OS and set skills directory
if [[ "$OSTYPE" == "darwin"* ]]; then
    SKILLS_BASE="$HOME/Library/Application Support/Claude"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    SKILLS_BASE="$HOME/.config/Claude"
else
    echo "ERROR: Unsupported OS. Please install manually."
    exit 1
fi

SKILLS_PLUGIN="$SKILLS_BASE/local-agent-mode-sessions/skills-plugin"

if [ ! -d "$SKILLS_PLUGIN" ]; then
    echo "ERROR: Could not find Claude skills directory."
    echo "Make sure Claude Code is installed and opened at least once."
    echo "Expected path: $SKILLS_PLUGIN"
    exit 1
fi

SESSION_DIR=$(find "$SKILLS_PLUGIN" -maxdepth 1 -mindepth 1 -type d | head -1)

if [ -z "$SESSION_DIR" ]; then
    echo "ERROR: No Claude session found. Open Claude Code first."
    exit 1
fi

SKILLS_DIR=$(find "$SESSION_DIR" -maxdepth 2 -name "skills" -type d | head -1)

if [ -z "$SKILLS_DIR" ]; then
    echo "ERROR: Could not find skills folder. Open Claude Code and try again."
    exit 1
fi

TARGET="$SKILLS_DIR/generate-blog"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="$(dirname "$SCRIPT_DIR")"

echo "Installing to: $TARGET"
echo ""

mkdir -p "$TARGET/references"
cp "$SKILL_ROOT/SKILL.md" "$TARGET/"
cp "$SKILL_ROOT/references/blog-prompt.md" "$TARGET/references/"
cp "$SKILL_ROOT/references/system-prompt.md" "$TARGET/references/"

echo "✅ Skill installed successfully!"
echo ""
echo "----------------------------------------"
echo "Next steps:"
echo "1. Restart Claude Code"
echo "2. In a new chat, type:"
echo "   generate a blog for https://yourstore.com"
echo "----------------------------------------"
echo ""
