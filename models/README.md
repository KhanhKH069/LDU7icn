# Models

Model weights are NOT committed to git (too large).

## Download

```bash
# Run the download script
./scripts/download_models.sh

# Or manually:
# Whisper base (Vietnamese-optimized)
# https://huggingface.co/openai/whisper-base

# YOLOv8n (nano — fastest, for edge deployment)
# https://github.com/ultralytics/ultralytics
pip install ultralytics
python -c "from ultralytics import YOLO; YOLO('yolov8n.pt')"
```

## Recommended Models by Hardware

| Hardware | Whisper | YOLO |
|----------|---------|------|
| Raspberry Pi 5 | tiny / base | yolov8n |
| Jetson Nano | base / small | yolov8s |
| Laptop (CPU) | base / small | yolov8m |
| Laptop (GPU) | medium | yolov8l |
