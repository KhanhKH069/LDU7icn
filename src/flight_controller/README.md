# ✈️ Flight Controller — M3

Giao tiếp với ArduPilot/PX4 qua MAVLink, bộ điều khiển PID, giám sát an toàn.

## Test với SITL (không cần drone thật)
```bash
# Terminal 1: Chạy SITL
./scripts/start_sitl.sh

# Terminal 2: Chạy connection test
uv run python -c "from ldu7icn.flight_controller.mavlink_bridge.connection import *; test_connection()"
```

## Lệnh bay cơ bản
takeoff | land | hover | forward | backward | left | right | up | down | return_to_home

## Safety defaults
- Geofence: 100m radius
- Max altitude: 50m
- Low battery RTL: 20%
