#!/bin/bash

# Quick start script for Charades web server
# Run this to instantly start playing

echo "🎭 Starting Charades Game Server..."
echo ""
echo "Navigate to this directory:"
cd /Users/aakashgoradia/code/Charades

echo "✅ Directory: $(pwd)"
echo ""
echo "Starting Python web server on port 8000..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🌐 Open in browser: http://localhost:8000"
echo "📱 On iPhone: http://[YOUR_IP]:8000"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

python3 -m http.server 8000
