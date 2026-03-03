# 🔗 Integration — M4

Middleware kết nối tất cả module. API Gateway. MQTT Message Broker.

## Khởi động API server
```bash
uv run ldu7icn-api
# → http://localhost:8000
# → http://localhost:8000/docs  (Swagger UI)
```

## Kiến trúc message flow
```
[Voice M1] ──┐
              ├──→ command_bus.py ──→ pipeline.py ──→ [Flight M3]
[Vision M2] ──┘                          │
                                          └──→ mqtt_client.py ──→ [Mobile App M5]
                                          └──→ websocket_handler.py ──→ [Dashboard M5]
```

## MQTT Topics
| Topic | Direction | Payload |
|-------|-----------|---------|
| `uav/command` | App → System | UAVCommand JSON |
| `uav/telemetry` | System → App | GPS, altitude, battery |
| `uav/detection` | System → App | Bounding boxes |
| `uav/status` | System → App | System health |
