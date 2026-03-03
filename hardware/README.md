# 🔧 Hardware Setup

## Bill of Materials (BOM)

| Component | Specs | Quantity | Est. Cost |
|-----------|-------|----------|-----------|
| Drone Frame | F450 / S500 quadcopter frame | 1 | ~500k VND |
| Flight Controller | Pixhawk 6C / Matek F7 | 1 | ~2,000k VND |
| Raspberry Pi 5 | 8GB RAM | 1 | ~2,500k VND |
| Pi Camera Module 3 | 12MP, Wide FOV | 1 | ~800k VND |
| ESC (4x) | 30A BLHeli32 | 4 | ~1,200k VND |
| Motors (4x) | 2212 920KV / 2306 2450KV | 4 | ~800k VND |
| Battery | 4S 5000mAh LiPo | 1 | ~800k VND |
| RC Transmitter | FlySky FS-i6 or better | 1 | ~1,000k VND |
| Telemetry Radio | SiK 915MHz x2 | 1 pair | ~600k VND |
| Microphone | USB cardioid mic | 1 | ~200k VND |

**Tổng ước tính: ~10,400k VND (~420 USD)**

## Kết nối

```
[Raspberry Pi 5] ←—USB/Serial—→ [Pixhawk / Matek F7]
[Raspberry Pi 5] ←—CSI—→ [Pi Camera Module 3]
[Raspberry Pi 5] ←—USB—→ [Microphone]
[Pixhawk] ←—PWM/DSHOT—→ [4x ESC] ←—→ [4x Motor]
[Pixhawk] ←—Radio—→ [RC Transmitter]
[Pixhawk] ←—UART—→ [Telemetry Radio]
```

## Firmware
- Pixhawk: ArduCopter 4.5+ (flash via Mission Planner)
- Matek F7: ArduCopter via BetaFlight passthrough hoặc Betaflight

## Chi tiết lắp ráp
Xem `hardware/schematics/` cho sơ đồ kết nối chi tiết.
