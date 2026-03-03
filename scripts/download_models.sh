#!/usr/bin/env bash
# Download model weights for LDU7icn
set -e

echo "📥 Downloading YOLOv8n..."
uv run python -c "from ultralytics import YOLO; YOLO('yolov8n.pt')" && \
  mv yolov8n.pt models/yolo/yolov8n.pt 2>/dev/null || \
  cp ~/.cache/ultralytics/assets/yolov8n.pt models/yolo/ 2>/dev/null || true
echo "✅ YOLOv8n saved to models/yolo/"

echo "📥 Downloading Whisper base..."
uv run python -c "import whisper; whisper.load_model('base')"
echo "✅ Whisper base cached"

echo ""
echo "🎉 All models ready!"
