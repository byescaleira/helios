#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔍 Validating iOS Expert plugin..."

# Check JSON files
for file in "$PLUGIN_DIR/.claude-plugin/plugin.json" "$PLUGIN_DIR/.mcp.json" "$PLUGIN_DIR/hooks/hooks.json"; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing $file"
        exit 1
    fi
    if ! python3 -m json.tool "$file" > /dev/null 2>&1; then
        echo "❌ Invalid JSON: $file"
        exit 1
    fi
    echo "✅ $file"
done

# Check skills
for skill_dir in "$PLUGIN_DIR"/skills/*/; do
    skill_file="$skill_dir/SKILL.md"
    if [ ! -f "$skill_file" ]; then
        echo "❌ Missing SKILL.md in $skill_dir"
        exit 1
    fi
    if ! grep -q '^---$' "$skill_file"; then
        echo "❌ Missing frontmatter in $skill_file"
        exit 1
    fi
    echo "✅ $(basename "$skill_dir")"
done

# Check agents
for agent_file in "$PLUGIN_DIR"/agents/*.md; do
    if [ ! -f "$agent_file" ]; then
        echo "❌ Missing agent file"
        exit 1
    fi
    if ! grep -q '^---$' "$agent_file"; then
        echo "❌ Missing frontmatter in $agent_file"
        exit 1
    fi
    echo "✅ $(basename "$agent_file")"
done

echo ""
echo "🎉 Plugin structure is valid."
echo ""
echo "To install locally:"
echo "  cd $PLUGIN_DIR"
echo "  claude plugin install ."
