# 🎤 Voice Control — M1

Pipeline: Microphone → Whisper STT → NLP Parser → UAVCommand

## Luồng xử lý
```
audio_capture.py → vad.py → transcriber.py → intent_detector.py → entity_extractor.py → mapper.py → UAVCommand
```

## Chạy riêng lẻ
```bash
uv run ldu7icn-voice
```

## Lệnh được hỗ trợ
Xem `configs/config.yaml` phần `commands:` để biết tất cả từ khoá tiếng Việt/Anh được nhận diện.
