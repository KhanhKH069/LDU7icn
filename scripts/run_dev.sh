#!/usr/bin/env bash
# Start full LDU7icn development stack
set -e

echo "🚀 Starting LDU7icn development stack..."

# Check .env exists
if [ ! -f .env ]; then
    echo "⚠️  .env not found. Copying from .env.example..."
    cp .env.example .env
fi

# Start API gateway (main process)
echo "🌐 Starting API server at http://localhost:8000 ..."
uv run ldu7icn-api &
API_PID=$!

# Start voice control
echo "🎤 Starting voice control module..."
uv run ldu7icn-voice &
VOICE_PID=$!

# Start vision module
echo "👁️  Starting computer vision module..."
uv run ldu7icn-vision &
VISION_PID=$!

echo ""
echo "✅ All services started!"
echo "   API:       http://localhost:8000"
echo "   API Docs:  http://localhost:8000/docs"
echo "   Dashboard: http://localhost:8000/dashboard"
echo ""
echo "Press Ctrl+C to stop all services..."

# Wait and cleanup on exit
trap "kill $API_PID $VOICE_PID $VISION_PID 2>/dev/null; echo 'Stopped.'" EXIT
wait
