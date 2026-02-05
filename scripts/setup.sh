#!/bin/bash
# CGSD Installation Script
# Installs the CGSD framework for Claude Code

set -e

echo "=== CGSD Setup ==="

# Check if claude CLI is available
if ! command -v claude &> /dev/null; then
    echo "ERROR: Claude CLI not found. Install Claude Code first:"
    echo "  npm install -g @anthropic-ai/claude-code"
    exit 1
fi

# Check if CGSD is already installed
if claude --help 2>/dev/null | grep -q "cgsd:"; then
    echo "CGSD is already installed."
    echo "Run '/cgsd:help' in Claude Code to see available commands."
    exit 0
fi

# Install CGSD
echo "Installing CGSD framework..."
npx get-shit-done-cc --claude --local

echo ""
echo "=== Installation Complete ==="
echo ""
echo "CGSD has been installed. Start a new Claude Code session to use it."
echo ""
echo "Quick start:"
echo "  1. claude --dangerously-skip-permissions"
echo "  2. /cgsd:new-project    # Start a new project"
echo "  3. /cgsd:help           # See all commands"
