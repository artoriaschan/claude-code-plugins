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

# Remove existing symlink if present
if [ -L "$TARGET_DIR" ]; then
  echo "Removing existing symlink: $TARGET_DIR"
  rm "$TARGET_DIR"
elif [ -e "$TARGET_DIR" ]; then
  echo "Error: $TARGET_DIR already exists and is not a symlink. Remove it manually first."
  exit 1
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
