# Whisper CLI — Local Speech-to-Text

## Install (macOS)
```bash
brew install whisper-cpp

# Download the base English model
mkdir -p ~/.cache/whisper
curl -L -o ~/.cache/whisper/ggml-base.en.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
```

## Usage

Voice messages need conversion to WAV first:
```bash
# Convert voice message to WAV (16kHz mono)
ffmpeg -i input.ogg -ar 16000 -ac 1 /tmp/voice.wav -y

# Transcribe
whisper-cli -m ~/.cache/whisper/ggml-base.en.bin -f /tmp/voice.wav --no-timestamps
```

### Models (accuracy vs speed)
| Model | Size | Speed | Use |
|-------|------|-------|-----|
| `ggml-tiny.en.bin` | 75MB | ⚡ Fastest | Quick drafts |
| `ggml-base.en.bin` | 142MB | 🔄 Balanced | **Recommended** |
| `ggml-small.en.bin` | 466MB | 🐢 Slower | Better accuracy |

### Tips
- Always use `--no-timestamps` for clean text output
- `ffmpeg` must be installed (`brew install ffmpeg`)
- Works entirely offline — no API calls, no data leaves your machine
