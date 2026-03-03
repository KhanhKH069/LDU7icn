# 📋 Phân công công việc — Dự án LDU7icn

## Tổng quan nhóm

| ID | Vai trò | Module chính |
|----|---------|--------------|
| **M1** | AI / Speech Engineer | `voice_control/` |
| **M2** | Computer Vision Engineer | `computer_vision/` |
| **M3** | Flight Systems Engineer | `flight_controller/` |
| **M4** | Integration & Backend Engineer | `integration/` |
| **M5** | UI / QA Engineer | `ui/` + `tests/` |

---

## M1 — AI / Speech Engineer

**Mô tả:** Xây dựng toàn bộ pipeline nhận diện và hiểu giọng nói tiếng Việt/tiếng Anh, từ thu âm đến phân tích ý định lệnh bay.

### Đầu việc cụ thể

| Task | File | Mô tả | Tuần |
|------|------|-------|------|
| Setup Whisper | `whisper_module/transcriber.py` | Load model, chạy STT real-time | 1–2 |
| Thu âm real-time | `whisper_module/audio_capture.py` | Ghi âm từ mic, buffer chunked audio | 1–2 |
| Voice Activity Detection | `whisper_module/vad.py` | Phát hiện khi có tiếng người nói | 2–3 |
| Intent Detector | `nlp_parser/intent_detector.py` | Nhận ra ý định: bay, hạ cánh, bám mục tiêu... | 3–4 |
| Entity Extractor | `nlp_parser/entity_extractor.py` | Trích xuất tham số: "sang phải **2 mét**", "lên **5m**" | 4–5 |
| Command Mapper | `command_mapper/mapper.py` | Ánh xạ intent + entities → UAVCommand object | 5–6 |
| Command Schema | `command_mapper/command_schema.py` | Pydantic models cho tất cả lệnh UAV | 3 |
| Fine-tune Whisper VI | `models/fine_tuned/` | Optional: fine-tune với tập lệnh UAV tiếng Việt | 9–12 |
| Unit tests | `tests/unit/test_whisper.py` | Test pipeline giọng nói | ongoing |

### Kỹ năng cần có
- Python, PyTorch
- OpenAI Whisper API & local inference
- NLP cơ bản (intent classification, NER)
- Kiến thức về xử lý tín hiệu âm thanh

### Deliverables (Phase 1)
- [ ] Whisper nhận lệnh tiếng Việt, độ chính xác > 90% với 20 lệnh cơ bản
- [ ] Latency STT < 500ms với model `base`
- [ ] Schema đầy đủ cho tất cả lệnh bay

---

## M2 — Computer Vision Engineer

**Mô tả:** Xây dựng hệ thống nhận diện và bám theo mục tiêu real-time qua camera drone, tích hợp YOLOv8 và DeepSORT.

### Đầu việc cụ thể

| Task | File | Mô tả | Tuần |
|------|------|-------|------|
| Setup YOLOv8 | `yolo_module/model_loader.py` | Load YOLOv8n, optimize cho Raspberry Pi | 1–2 |
| Detection Pipeline | `yolo_module/detector.py` | Real-time detection từ camera, 30 FPS | 2–3 |
| Object Tracker | `target_tracker/tracker.py` | Interface bám nhiều vật thể giữa các frame | 3–4 |
| DeepSORT | `target_tracker/deepsort.py` | Implement DeepSORT / ByteTrack | 4–6 |
| Depth Estimator | `depth_estimator/estimator.py` | Ước tính khoảng cách tới mục tiêu (stereo/mono) | 6–8 |
| Camera Calibration | `depth_estimator/calibration.py` | Calibrate Pi Camera, undistortion | 2–3 |
| Tích hợp YOLO+Track | — | Kết hợp detection + tracking thành pipeline | 6–7 |
| Test trên Pi | — | Benchmark FPS và memory trên Raspberry Pi 5 | 9–10 |
| Unit tests | `tests/unit/test_yolo.py` | Test detection accuracy | ongoing |

### Kỹ năng cần có
- Python, OpenCV
- Ultralytics YOLOv8
- Computer Vision, Camera geometry
- Kinh nghiệm Raspberry Pi / edge devices là lợi thế

### Deliverables (Phase 1)
- [ ] YOLOv8n chạy ≥ 15 FPS trên Raspberry Pi 5
- [ ] Tracking mục tiêu ổn định qua > 30 frames
- [ ] Xuất bounding box + class + track_id + estimated distance

---

## M3 — Flight Systems Engineer

**Mô tả:** Xây dựng layer giao tiếp với drone (MAVLink), bộ điều khiển PID, và hệ thống giám sát an toàn bay. Đây là module quan trọng nhất liên quan đến phần cứng thật.

### Đầu việc cụ thể

| Task | File | Mô tả | Tuần |
|------|------|-------|------|
| MAVLink Connection | `mavlink_bridge/connection.py` | Kết nối SITL và drone thật, reconnect logic | 1–2 |
| Commander | `mavlink_bridge/commander.py` | Gửi lệnh: takeoff, land, goto, velocity | 2–4 |
| Telemetry Reader | `mavlink_bridge/telemetry.py` | GPS, altitude, battery, attitude real-time | 2–3 |
| PID Core | `pid_controller/pid.py` | PID algorithm với anti-windup | 4–5 |
| Autopilot | `pid_controller/autopilot.py` | Follow target logic dùng PID + vision data | 6–8 |
| Safety Monitor | `safety_monitor/monitor.py` | Cảnh báo pin yếu, mất tín hiệu, lỗi cảm biến | 3–4 |
| Geofence | `safety_monitor/geofence.py` | Giới hạn vùng bay, tự động RTL khi ra ngoài | 4–5 |
| SITL Setup | `scripts/start_sitl.sh` | Script chạy ArduPilot SITL | 1 |
| HIL Tests | `tests/hardware_in_loop/test_sitl.py` | Test bay với simulator | ongoing |
| Lắp drone thật | `hardware/` | Lắp ráp, flash firmware, kết nối Pi | 9–11 |

### Kỹ năng cần có
- Python, pymavlink / dronekit
- Kiến thức ArduPilot / PX4
- Điều khiển học (PID), cơ học bay
- Kinh nghiệm drone / RC là bắt buộc

### Deliverables (Phase 1)
- [ ] Kết nối và điều khiển thành công qua SITL
- [ ] 10 lệnh bay cơ bản hoạt động: takeoff, land, forward/back/left/right/up/down, hover, RTL
- [ ] Safety monitor tự động hạ cánh khi pin < 20%

---

## M4 — Integration & Backend Engineer

**Mô tả:** Kết nối tất cả module lại, xây dựng API server, message bus MQTT, và pipeline xử lý trung tâm. Là "hệ thần kinh" của toàn dự án.

### Đầu việc cụ thể

| Task | File | Mô tả | Tuần |
|------|------|-------|------|
| Config System | `config.py` | Pydantic-settings, load .env + config.yaml | 1 |
| Command Bus | `integration/middleware/command_bus.py` | Event-driven routing giữa các module | 3–4 |
| Main Pipeline | `integration/middleware/pipeline.py` | Orchestrate: Voice→NLP→Flight / Vision→Track→Flight | 4–6 |
| FastAPI Server | `integration/api_gateway/server.py` | App khởi động, CORS, middleware | 2–3 |
| HTTP Routes | `integration/api_gateway/routes.py` | REST endpoints: /command, /telemetry, /status | 3–4 |
| WebSocket | `integration/api_gateway/websocket_handler.py` | Stream telemetry + video đến dashboard | 4–5 |
| MQTT Client | `integration/message_broker/mqtt_client.py` | Pub/sub topics cho mobile app | 5–6 |
| Topic Schema | `integration/message_broker/topics.py` | JSON schema cho mọi MQTT message | 3 |
| Main Entry | `main.py` | Start tất cả services cùng lúc | 6–7 |
| API Docs | `docs/api_docs/` | OpenAPI spec, WebSocket protocol docs | 7–8 |
| run_dev script | `scripts/run_dev.sh` | Script chạy full stack dev | 2 |
| Integration tests | `tests/integration/` | Test toàn pipeline | ongoing |

### Kỹ năng cần có
- Python, FastAPI, asyncio
- WebSocket, MQTT
- System design, API design
- Docker là lợi thế

### Deliverables (Phase 1)
- [ ] API server chạy, đầy đủ docs tại `/docs`
- [ ] Pipeline Voice→Flight hoạt động end-to-end với SITL
- [ ] WebSocket stream telemetry real-time đến dashboard

---

## M5 — UI / QA Engineer

**Mô tả:** Xây dựng giao diện người dùng (web dashboard + mobile app) và đảm bảo chất lượng toàn bộ hệ thống thông qua test suite.

### Đầu việc cụ thể

| Task | File | Mô tả | Tuần |
|------|------|-------|------|
| Web Dashboard | `ui/dashboard/` | Hiển thị telemetry, video stream, nút điều khiển | 4–7 |
| Dashboard Components | `ui/dashboard/components.py` | Map, altitude chart, status indicators | 5–7 |
| Mobile App | `ui/mobile_app/` | React Native Expo: điều khiển + xem telemetry | 7–12 |
| Unit test M1 | `tests/unit/test_whisper.py` | Test STT pipeline | 3–4 |
| Unit test M2 | `tests/unit/test_yolo.py` | Test detection accuracy | 3–4 |
| Unit test mapper | `tests/unit/test_mapper.py` | Test command mapping | 3–4 |
| Unit test PID | `tests/unit/test_pid.py` | Test PID controller | 4–5 |
| Integration test | `tests/integration/test_pipeline.py` | Test pipeline đầy đủ | 6–8 |
| API test | `tests/integration/test_api.py` | Test tất cả endpoints | 5–7 |
| HIL test | `tests/hardware_in_loop/test_sitl.py` | Test bay với SITL | 8–10 |
| conftest | `tests/conftest.py` | Shared fixtures | 2 |
| CI/CD | `.github/workflows/` | GitHub Actions: test + lint | 3–4 |
| Demo video | `assets/` | Quay video demo sản phẩm | 14–15 |

### Kỹ năng cần có
- Python pytest, async testing
- React / React Native (Expo)
- JavaScript / TypeScript
- UI/UX design cơ bản

### Deliverables (Phase 1)
- [ ] Coverage > 70% cho tất cả unit tests
- [ ] Dashboard hiển thị telemetry real-time qua WebSocket
- [ ] CI chạy tự động khi push code

---

## 🔗 Điểm giao thoa giữa các thành viên

```
M1 (Voice)  ──→  command_schema.py  ──→  M4 (Integration)
M2 (Vision) ──→  BoundingBox + TrackID ──→  M4 (Integration)
M3 (Flight) ──→  Telemetry data  ──→  M4 (Integration)
M4 (Backend)──→  WebSocket API  ──→  M5 (UI)
M4 (Backend)──→  MQTT topics  ──→  M5 (Mobile)
```

**Quy tắc tích hợp:**
- M4 là người định nghĩa interface (schema) trước — M1, M2, M3 implement theo
- Mỗi module phải có unit test trước khi merge vào `main`
- Code review: ít nhất 1 người khác approve trước khi merge

---

## 📅 Milestones chính

| Tuần | Milestone | Người chịu trách nhiệm |
|------|-----------|----------------------|
| 2 | Environment setup xong, SITL chạy được | M3, M4 |
| 4 | Whisper nhận lệnh tiếng Việt ổn định | M1 |
| 4 | YOLO detect từ webcam real-time | M2 |
| 6 | Pipeline Voice→SITL hoạt động end-to-end | M1, M3, M4 |
| 8 | Vision tracking + autopilot follow target trên SITL | M2, M3, M4 |
| 10 | Dashboard + API hoàn chỉnh | M4, M5 |
| 12 | Bay thực tế thành công (indoor) | All |
| 14 | Mobile app + demo video | M5 |
| 16 | Demo ngày bảo vệ | All |
