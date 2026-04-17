#!/bin/bash
# Install code-style plugin rules by copying them to ~/.claude/rules/code-style/
#
# Usage:
#   Local:   cd plugins/code-style && ./install.sh
#   Local:   bash plugins/code-style/install.sh
#   Remote:  curl -fsSL https://raw.githubusercontent.com/artoriaschan/claude-code-dev-plugins/main/plugins/code-style/install.sh | bash

set -e

REPO_OWNER="artoriaschan"
REPO_NAME="claude-code-dev-plugins"
BRANCH="main"
PLUGIN_PATH="plugins/code-style/rules"
TARGET_DIR="$HOME/.claude/rules/code-style"

RAW_BASE="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${BRANCH}"

echo "Installing code-style plugin rules..."

# Resolve script directory (works for both local file and curl pipe)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"

# Determine rules source: local if rules directory exists relative to script, otherwise download from GitHub
if [ -d "$SCRIPT_DIR/rules" ] && [ -f "$SCRIPT_DIR/rules/common/coding-style.md" ]; then
  SOURCE_DIR="$SCRIPT_DIR/rules"
  echo "Using local rules from: $SOURCE_DIR"
else
  echo "Downloading rules from GitHub: ${REPO_OWNER}/${REPO_NAME}/${BRANCH}"
  TMP_DIR=$(mktemp -d)
  trap 'rm -rf "$TMP_DIR"' EXIT

  RULES_URL="${RAW_BASE}/${PLUGIN_PATH}"
  # Download each subdirectory
  for dir in common typescript react vue scss; do
    mkdir -p "$TMP_DIR/$dir"
    # Get file list from GitHub API
    API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents/${PLUGIN_PATH}/${dir}?ref=${BRANCH}"
    files=$(curl -fsSL "$API_URL" | grep -o '"name":"[^"]*\.md"' | grep -o '"[^"]*\.md"$' | tr -d '"' || true)
    for f in $files; do
      curl -fsSL "${RULES_URL}/${dir}/${f}" -o "$TMP_DIR/$dir/$f" || echo "Warning: failed to download ${dir}/${f}"
    done
  done
  SOURCE_DIR="$TMP_DIR"
fi

# Remove existing symlink or directory if present
if [ -L "$TARGET_DIR" ]; then
  echo "Removing existing symlink: $TARGET_DIR"
  rm "$TARGET_DIR"
elif [ -d "$TARGET_DIR" ]; then
  echo "Removing existing rules directory: $TARGET_DIR"
  rm -rf "$TARGET_DIR"
fi

# Create parent directory if needed
mkdir -p "$HOME/.claude/rules"

# Copy rules to target
cp -r "$SOURCE_DIR" "$TARGET_DIR"

echo "Rules installed: $TARGET_DIR"
echo ""
echo "Installation complete!"
