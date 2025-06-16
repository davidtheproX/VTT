# Android TTS Setup Guide

## Issue Detected
Your logcat shows:
```
TTS initialization failed
getLanguage failed: not bound to TTS engine
```

This means Android TTS is not properly set up on your device.

## Quick Fix Steps:

### 1. Install Google Text-to-Speech
- Open **Google Play Store**
- Search for "Google Text-to-Speech"
- Install/Update it

### 2. Enable TTS in Android Settings
- Go to **Settings** → **Accessibility** → **Text-to-speech**
- Select **Google Text-to-Speech** as preferred engine
- Tap **Settings** next to Google TTS
- Download English (US) voice data if not already downloaded

### 3. Test TTS in Settings
- In TTS settings, tap **"Listen to an example"**
- You should hear a voice say "This is an example of speech synthesis"
- If no sound, check your media volume

### 4. Alternative: Samsung TTS
If Google TTS doesn't work:
- Try **Samsung Text-to-Speech** (on Samsung devices)
- Or install **eSpeak TTS** from Play Store

### 5. Verify Setup
After setup:
- Restart the VTT app
- Tap the 🔊 test button
- Check logcat for: "TTS is ready, updating voices..."

## Common Issues:

1. **No voice data**: Download language pack in TTS settings
2. **TTS disabled**: Enable in Accessibility settings  
3. **No media volume**: Check device media volume (not ringer)
4. **Old TTS engine**: Update Google TTS in Play Store

## Debug Commands:
```bash
# Check TTS engine status
adb shell settings get secure tts_default_synth

# List installed TTS packages
adb shell pm list packages | grep tts
``` 