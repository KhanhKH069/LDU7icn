# 🚁 LDU7icn — UAV Multimodal Control System

> **Nghiên cứu và phát triển hệ thống điều khiển UAV đa phương thức, tích hợp mô hình AI nhận dạng giọng nói (Whisper) và thị giác máy tính (YOLO) để chuyển đổi mệnh lệnh ngôn ngữ tự nhiên thành hành động bay và định vị mục tiêu trong thời gian thực.**

---

## 🎯 Mục tiêu sản phẩm

- 🎤 **Điều khiển giọng nói** — Nói tiếng Việt / tiếng Anh → UAV thực hiện lệnh (<200ms latency)
- 👁️ **Nhận diện & bám mục tiêu** — YOLOv8 real-time qua camera gắn drone
- 🤖 **Tự động hóa** — Pipeline hoàn chỉnh: giọng nói → NLP → MAVLink → hành động bay
- 📱 **App điều khiển** — Dashboard web + mobile app real-time telemetry
- 🛸 **Sản phẩm thực** — Drone bay được, demo ngoài thực tế

---

## 👥 Phân công nhóm 5 người

| # | Vai trò | Phụ trách module | File chính |
|---|---------|-----------------|------------|
| **M1** | AI / Speech Engineer | `voice_control/` | whisper_module, nlp_parser, command_mapper |
| **M2** | Computer Vision Engineer | `computer_vision/` | yolo_module, target_tracker, depth_estimator |
| **M3** | Flight Systems Engineer | `flight_controller/` | mavlink_bridge, pid_controller, safety_monitor |
| **M4** | Integration & Backend Engineer | `integration/` | middleware, api_gateway, message_broker |
| **M5** | UI / QA Engineer | `ui/` + `tests/` | dashboard, mobile_app, toàn bộ test suite |

---

## 🗂️ Cấu trúc thư mục

```
LDU7icn/
├── src/
│   ├── voice_control/              # M1
│   │   ├── whisper_module/         # STT — OpenAI Whisper
│   │   │   ├── transcriber.py      # Pipeline chuyển audio → text
│   │   │   ├── audio_capture.py    # Thu âm real-time (sounddevice)
│   │   │   └── vad.py              # Voice Activity Detection
│   │   ├── nlp_parser/             # Phân tích ý định câu lệnh
│   │   │   ├── intent_detector.py  # Nhận diện intent (bay, theo dõi...)
│   │   │   └── entity_extractor.py # Trích xuất tham số (hướng, tốc độ)
│   │   └── command_mapper/         # Ánh xạ intent → UAV command
│   │       ├── mapper.py
│   │       └── command_schema.py   # Pydantic schema cho lệnh
│   │
│   ├── computer_vision/            # M2
│   │   ├── yolo_module/            # Object Detection — YOLOv8
│   │   │   ├── detector.py         # Real-time detection pipeline
│   │   │   └── model_loader.py     # Load & cache model
│   │   ├── target_tracker/         # Bám mục tiêu đa frame
│   │   │   ├── tracker.py          # Tracker interface
│   │   │   └── deepsort.py         # DeepSORT / ByteTrack implementation
│   │   └── depth_estimator/        # Ước tính khoảng cách tới mục tiêu
│   │       ├── estimator.py
│   │       └── calibration.py      # Camera calibration utils
│   │
│   ├── flight_controller/          # M3
│   │   ├── mavlink_bridge/         # Giao tiếp ArduPilot/PX4
│   │   │   ├── connection.py       # MAVLink connection manager
│   │   │   ├── commander.py        # Gửi lệnh bay (takeoff, goto, land)
│   │   │   └── telemetry.py        # Đọc dữ liệu cảm biến real-time
│   │   ├── pid_controller/         # Bộ điều khiển PID
│   │   │   ├── pid.py              # PID core algorithm
│   │   │   └── autopilot.py        # Autopilot logic (follow target)
│   │   └── safety_monitor/         # Giám sát an toàn bay
│   │       ├── monitor.py          # Battery, signal, altitude alerts
│   │       └── geofence.py         # Giới hạn vùng bay
│   │
│   ├── integration/                # M4
│   │   ├── middleware/             # Lõi hệ thống — kết nối tất cả module
│   │   │   ├── pipeline.py         # Main processing pipeline
│   │   │   └── command_bus.py      # Event-driven command routing
│   │   ├── api_gateway/            # REST + WebSocket API
│   │   │   ├── server.py           # FastAPI app entry point
│   │   │   ├── routes.py           # HTTP endpoints
│   │   │   └── websocket_handler.py# Real-time WS (telemetry, video stream)
│   │   └── message_broker/         # MQTT pub/sub
│   │       ├── mqtt_client.py      # Paho MQTT client
│   │       └── topics.py           # Topic definitions & schemas
│   │
│   ├── ui/                         # M5
│   │   ├── dashboard/              # Web dashboard (FastAPI + Jinja2)
│   │   │   ├── app.py
│   │   │   └── components.py
│   │   └── mobile_app/             # React Native (separate repo / subfolder)
│   │
│   ├── main.py                     # Entry point toàn hệ thống
│   └── config.py                   # Config loader (pydantic-settings)
│
├── tests/
│   ├── unit/                       # M5 — Test từng module
│   ├── integration/                # M5 — Test kết hợp module
│   └── hardware_in_loop/           # M3+M5 — Test với SITL simulator
│
├── models/                         # Model weights (xem models/README.md)
├── hardware/                       # Sơ đồ mạch, firmware, CAD
├── docs/                           # Tài liệu kỹ thuật
├── configs/config.yaml             # Cấu hình hệ thống
├── scripts/                        # Bash scripts tiện ích
├── pyproject.toml                  # uv project & dependencies
└── .env.example                    # Biến môi trường mẫu
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Speech-to-Text | OpenAI Whisper (tiny/base — edge optimized) |
| Object Detection | YOLOv8n (Ultralytics) |
| Object Tracking | DeepSORT / ByteTrack |
| Flight Controller | ArduPilot + MAVLink (pymavlink, dronekit) |
| Backend API | FastAPI + WebSocket |
| Message Bus | MQTT (Mosquitto + paho-mqtt) |
| Hardware | Raspberry Pi 5 + F7 Flight Controller + Pi Camera |
| Mobile App | React Native (Expo) |
| Dashboard | React + Vite + WebSocket |
| Package Manager | uv |

---

## 🚀 Quick Start

```bash
# 1. Clone project
git clone <repo-url>
cd LDU7icn

# 2. Setup môi trường (uv)
uv sync

# 3. Copy và cấu hình env
cp .env.example .env
# Chỉnh sửa .env theo môi trường của bạn

# 4. Download models
./scripts/download_models.sh

# 5. Chạy SITL simulator (ArduPilot) — test không cần drone thật
./scripts/start_sitl.sh

# 6. Chạy hệ thống
./scripts/run_dev.sh

# Hoặc chạy từng service:
uv run ldu7icn-api       # API Server tại http://localhost:8000
uv run ldu7icn-voice     # Voice control module
uv run ldu7icn-vision    # Computer vision module
```

---

## 🗓️ Lộ trình phát triển

### Phase 1 — Foundation (Tuần 1–4)
- [ ] Setup môi trường dev, CI/CD, repo structure
- [ ] Whisper hoạt động với tiếng Việt, nhận lệnh cơ bản
- [ ] YOLOv8 nhận diện người/vật thể từ webcam
- [ ] MAVLink kết nối SITL simulator (không cần drone thật)

### Phase 2 — Core Pipeline (Tuần 5–8)
- [ ] Pipeline đầy đủ: Mic → Whisper → NLP → MAVLink → SITL
- [ ] Real-time tracking mục tiêu qua camera
- [ ] API Gateway + WebSocket telemetry
- [ ] Dashboard monitoring cơ bản

### Phase 3 — Integration (Tuần 9–12)
- [ ] Tích hợp lên Raspberry Pi 5 gắn drone thật
- [ ] Test bay thực tế trong nhà (indoor)
- [ ] Mobile app hoàn chỉnh
- [ ] Tối ưu latency < 200ms end-to-end

### Phase 4 — Product Demo (Tuần 13–16)
- [ ] Demo sản phẩm outdoor
- [ ] Báo cáo + poster + video
- [ ] Documentation hoàn chỉnh
- [ ] Open source release

---

## 📄 Tài liệu chi tiết

- [`docs/specs/system_architecture.md`](docs/specs/system_architecture.md) — Kiến trúc hệ thống
- [`docs/specs/api_specification.md`](docs/specs/api_specification.md) — API Reference
- [`docs/specs/hardware_setup.md`](docs/specs/hardware_setup.md) — Hướng dẫn lắp ráp phần cứng
- [`docs/specs/task_breakdown.md`](docs/specs/task_breakdown.md) — Phân công chi tiết từng thành viên

---

*Dự án LDU7icn — 2025–2026*
