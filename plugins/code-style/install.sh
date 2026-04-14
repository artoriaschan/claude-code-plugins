#!/bin/bash
# Install code-style plugin rules by linking them to ~/.claude/rules/code-style/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULES_DIR="$SCRIPT_DIR/rules"
TARGET_DIR="$HOME/.claude/rules/code-style"

echo "Installing code-style plugin rules..."

# Check if rules directory exists
if [ ! -d "$RULES_DIR" ]; then
  echo "Error: rules/ directory not found in plugin directory"
  exit 1
fi

# Remove existing link/target if present
if [ -L "$TARGET_DIR" ] || [ -d "$TARGET_DIR" ]; then
  echo "Removing existing target: $TARGET_DIR"
  rm -rf "$TARGET_DIR"
fi

# Create parent directory if needed
mkdir -p "$HOME/.claude/rules"

# Create symlink
ln -s "$RULES_DIR" "$TARGET_DIR"

echo "Rules linked: $TARGET_DIR -> $RULES_DIR"
echo ""
echo "Installation complete!"
echo ""
echo "Skills, Hooks, and Agents are auto-discovered by Claude Code."
echo "To test: cc --plugin-dir $SCRIPT_DIR"
