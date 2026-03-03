# 👁️ Computer Vision — M2

Pipeline: Camera → YOLOv8 Detection → DeepSORT Tracking → Depth Estimation → Target Position

## Luồng xử lý
```
Camera → model_loader.py → detector.py → tracker.py → estimator.py → (x, y, z, track_id)
```

## Chạy riêng lẻ
```bash
uv run ldu7icn-vision
```

## Benchmark mục tiêu
| Device | FPS | Model |
|--------|-----|-------|
| RPi 5 | ≥15 | yolov8n |
| Laptop CPU | ≥30 | yolov8n |
| Laptop GPU | ≥60 | yolov8s |
