#!/bin/bash

echo "🔍 Pulse Project Validation"
echo "=========================="
echo ""

# Check file counts
echo "📊 File Statistics:"
echo "  Swift files: $(find . -name '*.swift' | wc -l)"
echo "  Plist files: $(find . -name '*.plist' -o -name '*.plist.template' | wc -l)"
echo "  Total lines: $(find . -name '*.swift' -exec wc -l {} + | tail -1 | awk '{print $1}')"
echo ""

# Check for syntax errors (basic)
echo "📝 Checking Swift files for common issues..."
errors=0

# Check for common syntax issues
for file in $(find . -name "*.swift"); do
    # Check for unmatched braces
    open=$(grep -o '{' "$file" | wc -l)
    close=$(grep -o '}' "$file" | wc -l)
    if [ $open -ne $close ]; then
        echo "  ⚠️  Mismatched braces in: $file (open: $open, close: $close)"
        ((errors++))
    fi
done

echo ""
echo "📁 Required Files Check:"
required_files=(
    "Pulse/PulseApp.swift"
    "Pulse/Info.plist"
    "Pulse/Pulse.entitlements"
    "PulseWidget/PulseWidget.swift"
    "PulseWidget/Info.plist"
    "Config/Supabase.plist"
    "Config/PostHog.plist"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ Missing: $file"
        ((errors++))
    fi
done

echo ""
echo "📦 Configuration Check:"
if grep -q "your-project.supabase.co" Config/Supabase.plist 2>/dev/null; then
    echo "  ⚠️  Supabase.plist has placeholder values (update with real keys)"
else
    echo "  ✅ Supabase.plist appears configured"
fi

if grep -q "your-posthog-project-api-key-here" Config/PostHog.plist 2>/dev/null; then
    echo "  ⚠️  PostHog.plist has placeholder values (update with real keys)"
else
    echo "  ✅ PostHog.plist appears configured"
fi

echo ""
echo "🎯 Summary:"
if [ $errors -eq 0 ]; then
    echo "  ✅ No major issues found!"
    echo "  ℹ️  Note: This doesn't check Swift syntax fully - use Xcode for that"
else
    echo "  ⚠️  Found $errors potential issues"
fi

