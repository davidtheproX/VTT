import QtQuick
import QtTextToSpeech

Item {
    id: root

        // Properties to expose TTS functionality
    property bool isEnabled: ttsEnabled && tts.state === TextToSpeech.Ready
    property bool isSpeaking: tts.state === TextToSpeech.Speaking
    property var availableVoices: tts.availableVoices  // Direct QVoice list
    property var voiceNames: voiceDisplayNames  // String list for UI
    property string currentVoiceName: tts.voice ? tts.voice.name : ""
    property real rate: tts.rate
    property real pitch: tts.pitch
    property real volume: tts.volume
    property int state: tts.state
    property var engineCapabilities: tts.engineCapabilities
    
    // Internal properties
    property bool ttsEnabled: true  // User-controlled TTS enable/disable (default: enabled)
    property var voiceDisplayNames: []  // Formatted voice names for display
    
    // Component initialization
    Component.onCompleted: {
        console.log("=== TTS COMPONENT INITIALIZED ===")
        console.log("TTS Enabled by default:", ttsEnabled)
        console.log("TTS Object available:", tts ? "Yes" : "No")
        console.log("Platform:", Qt.platform.os)
        
        if (tts) {
            console.log("TTS Engine:", tts.engine)
            console.log("TTS State:", tts.state)
            console.log("Available engines:", typeof tts.availableEngines === "function" ? tts.availableEngines() : "Method not available")
        }
        
        // Initialize TTS when component is ready
        if (tts.state === TextToSpeech.Ready) {
            console.log("TTS ready immediately, updating voices")
            updateVoices()
        } else {
            console.log("TTS not ready, waiting for state change...")
        }
        
        // Force update voices after a short delay to ensure TTS is ready
        Qt.callLater(function() {
            console.log("Delayed voice update check...")
            if (tts.state === TextToSpeech.Ready) {
                updateVoices()
                console.log("🚀 TTS ready! Automatic language detection enabled.")
            } else {
                console.log("TTS still not ready, state:", tts.state)
            }
        })
        
        console.log("=== END TTS INIT ===")
    }

    // Functions to control TTS enabled state (for settings compatibility)
    function setIsEnabled(enabled) {
        ttsEnabled = enabled
    }

    // Signals to maintain compatibility with existing QML code
    signal error(string message)
    signal voicesUpdated()

    

        // Cross-platform TTS test function with language detection
    function testTTS() {
        console.log("=== TTS TEST WITH LANGUAGE DETECTION ===")
        console.log("TTS State:", tts.state)
        console.log("Available voices:", tts.availableVoices.length)
        
        if (tts.state === TextToSpeech.Ready) {
            // Test English
            console.log("Testing English...")
            speak("Hello! This is an English test.")
            
            // Test Chinese  
            setTimeout(function() {
                console.log("Testing Chinese...")
                speak("你好！这是中文测试。")
            }, 3000)
            
            // Test mixed
            setTimeout(function() {
                console.log("Testing mixed language...")
                speak("Hello 你好 this is mixed text 这是混合文本")
            }, 6000)
        } else {
            console.error("TTS not ready for test! State:", tts.state)
            root.error("TTS not ready. Please check your system TTS settings.")
        }
    }
    
    // Debug function following Qt examples pattern
    function testChineseDetection() {
        console.log("=== TESTING CHINESE DETECTION ===")
        
        // Test various Chinese texts
        var testTexts = [
            "你好",
            "Hello", 
            "你好，世界！",
            "Hello 你好",
            "This is English text only",
            "这是中文文本",
            "你好吗？How are you?",
            "我很好，谢谢！I am fine, thanks!"
        ]
        
        for (var i = 0; i < testTexts.length; i++) {
            var text = testTexts[i]
            var detected = detectLanguage(text)
            console.log("Text:", text, "→ Detected:", detected)
        }
        
        console.log("=== END CHINESE DETECTION TEST ===")
    }
    
    // Debug function to show all available locales and voices (Qt examples style)
    function debugAvailableLocalesAndVoices() {
        console.log("=== AVAILABLE LOCALES & VOICES DEBUG ===")
        
        // Show all available locales
        var allLocales = tts.availableLocales
        console.log("Total available locales:", allLocales.length)
        
        for (var i = 0; i < Math.min(10, allLocales.length); i++) {
            var locale = allLocales[i]
            console.log("  Locale " + i + ":", locale.name, "(" + locale.nativeLanguageName + ")")
        }
        
        // Test Chinese locales specifically
        console.log("\n🔍 Searching for Chinese locales:")
        var chineseLocales = []
        for (var j = 0; j < allLocales.length; j++) {
            var loc = allLocales[j]
            if (loc.name.toLowerCase().includes("zh") || 
                loc.name.toLowerCase().includes("chinese")) {
                chineseLocales.push(loc)
                console.log("  ✅ Found Chinese locale:", loc.name, "(" + loc.nativeLanguageName + ")")
            }
        }
        
        if (chineseLocales.length === 0) {
            console.log("  ❌ No Chinese locales found in system")
        }
        
        // Test voices for Chinese locale
        if (chineseLocales.length > 0) {
            console.log("\n🎙️ Testing voices for first Chinese locale...")
            var originalLocale = tts.locale
            tts.locale = chineseLocales[0]
            
            var chineseVoices = tts.availableVoices
            console.log("Voices available for", chineseLocales[0].name + ":", chineseVoices.length)
            
            for (var k = 0; k < chineseVoices.length; k++) {
                var voice = chineseVoices[k]
                console.log("  Voice " + k + ":", voice.name, "(" + voice.locale.name + ")")
            }
            
            // Restore original locale
            tts.locale = originalLocale
        }
        
        console.log("=== END LOCALES & VOICES DEBUG ===")
    }

    

    // The main TextToSpeech object following Qt official examples
    TextToSpeech {
        id: tts

        // Initialize with English locale by default
        locale: Qt.locale("en-US")
        
        // Connect signals to update the UI when the engine's state changes
        onStateChanged: {
            console.log("TTS State changed to:", state)
            if (state === TextToSpeech.Ready) {
                console.log("TTS is ready, updating voices...")
                updateVoices()
                
                // Debug available voices and test VoiceSelector
                console.log("=== VOICE AVAILABILITY DEBUG ===")
                console.log("Total voices available:", tts.availableVoices.length)
                
                // List all voices with their locales
                for (var i = 0; i < Math.min(10, tts.availableVoices.length); i++) {
                    var voice = tts.availableVoices[i]
                    console.log("  " + i + ": " + voice.name + " (Locale: " + voice.locale.name + ")")
                }
                if (tts.availableVoices.length > 10) {
                    console.log("  ... and", (tts.availableVoices.length - 10), "more voices")
                }
                
                // Test if any Chinese locales are available
                var hasChineseVoices = false
                for (var j = 0; j < tts.availableVoices.length; j++) {
                    if (tts.availableVoices[j].locale.name.toLowerCase().includes("zh")) {
                        hasChineseVoices = true
                        console.log("✅ Found Chinese voice:", tts.availableVoices[j].name)
                    }
                }
                
                if (!hasChineseVoices) {
                    console.log("⚠️ No Chinese voices detected in system")
                    console.log("💡 Install Chinese language pack for TTS support")
                }
                
                console.log("=== END VOICE DEBUG ===")
            } else if (state === TextToSpeech.Error) {
                console.error("TTS Error state detected")
                root.error("TTS initialization failed. Please check your system TTS settings.")
            }
        }

        onEngineChanged: {
            console.log("TTS Engine changed")
            if (state === TextToSpeech.Ready) {
                updateVoices()
            }
        }

        onLocaleChanged: {
            console.log("TTS Locale changed")
            updateVoices()
        }

        onVoiceChanged: {
            console.log("TTS Voice changed to:", voice.name)
            root.currentVoiceName = voice.name
        }

        // Handle word-by-word highlighting if the engine supports it (Qt 6.6+)
        onSayingWord: (word, id, start, length) => {
            if (tts.engineCapabilities & TextToSpeech.WordByWordProgress) {
                console.log("Speaking word:", word, "in utterance:", id, "at position:", start, "length:", length)
                // You could emit a signal here for UI highlighting
            }
        }

        onErrorOccurred: (reason, errorString) => {
            console.error("TTS Error occurred - Reason:", reason, "Message:", errorString)
            root.error("TTS Error: " + errorString)
        }
    }



    // Public methods to match old TTSManager interface
    function speak(text) {
        console.log("=== TTS SPEAK WITH AUTO LANGUAGE DETECTION ===")
        console.log("Text preview:", text ? text.substring(0, 100) + "..." : "null/empty")
        
        if (!ttsEnabled) {
            console.log("❌ TTS is disabled, skipping speech")
            return
        }

        if (!text || text.trim().length === 0) {
            console.log("❌ Empty text provided, nothing to speak")
            return
        }

        var cleanText = cleanTextForSpeech(text)
        if (cleanText.length === 0) {
            console.log("❌ Text became empty after cleaning")
            return
        }
        
        // 🚀 AUTOMATIC LANGUAGE DETECTION AND VOICE SWITCHING
        var detectedLanguage = detectLanguage(cleanText)
        console.log("🌍 Detected language:", detectedLanguage)
        
        var voiceChanged = switchToLanguageVoice(detectedLanguage)
        if (voiceChanged) {
            console.log("🔄 Voice switched for language:", detectedLanguage)
        }
        
        if (tts.state === TextToSpeech.Ready) {
            console.log("🔊 Speaking in", detectedLanguage, "with voice:", tts.voice ? tts.voice.name : "Default")
            tts.say(cleanText)
        } else {
            console.error("❌ TTS not ready! State:", tts.state, "Error:", tts.errorString)
            root.error("TTS not ready: " + tts.errorString)
        }
        console.log("=== END TTS SPEAK ===")
    }

    function stop() {
        tts.stop()
    }

    function pause() {
        if (tts.engineCapabilities & TextToSpeech.PauseResume) {
            tts.pause()
        }
    }

    function resume() {
        if (tts.engineCapabilities & TextToSpeech.PauseResume) {
            tts.resume()
        }
    }

    function setCurrentVoice(voiceName) {
        console.log("setCurrentVoice called with:", voiceName)
        var voices = tts.availableVoices
        for (var i = 0; i < voices.length; i++) {
            if (voices[i].name === voiceName) {
                console.log("Setting voice to:", voices[i].name)
                tts.voice = voices[i]
                return true
            }
        }
        console.log("Voice not found:", voiceName)
        return false
    }
    
    // Enhanced voice selection with QVoice object
    function setVoice(voiceObject) {
        console.log("setVoice called with QVoice object")
        tts.voice = voiceObject
    }
    
    // Find voices by criteria (Qt 6.6+ feature)
    function findVoicesByGender(gender) {
        var voices = tts.availableVoices
        var filtered = []
        for (var i = 0; i < voices.length; i++) {
            if (voices[i].gender === gender) {
                filtered.push(voices[i])
            }
        }
        return filtered
    }

    function refreshVoices() {
        console.log("refreshVoices called manually")
        updateVoices()
    }
    
    // Function to get current voices immediately (for settings dialog)
    function getCurrentVoices() {
        console.log("getCurrentVoices called - TTS state:", tts.state)
        if (tts.state === TextToSpeech.Ready) {
            updateVoices()
        } else {
            console.log("TTS not ready for voice query")
        }
        return root.voiceDisplayNames
    }
    
    // Enhanced speak function with Qt 6.6+ enqueue support
    function speakQueue(textArray) {
        if (!ttsEnabled) {
            console.log("TTS is disabled, skipping speech queue")
            return
        }
        
        console.log("Speaking queue of", textArray.length, "items")
        
        // Use enqueue if available (Qt 6.6+)
        if (typeof tts.enqueue === "function") {
            for (var i = 0; i < textArray.length; i++) {
                var cleanText = cleanTextForSpeech(textArray[i])
                if (cleanText.length > 0) {
                    var id = tts.enqueue(cleanText)
                    console.log("Enqueued text with ID:", id)
                }
            }
        } else {
            // Fallback for older Qt versions
            console.log("enqueue not available, using sequential say()")
            for (var i = 0; i < textArray.length; i++) {
                speak(textArray[i])
            }
        }
    }
    
    // Helper function to clean text for speech
    function cleanTextForSpeech(text) {
        if (!text) return ""
        
        var cleanText = text.toString()
        cleanText = cleanText.replace(/\*/g, "") // Remove markdown emphasis
        cleanText = cleanText.replace(/`/g, "") // Remove code formatting
        cleanText = cleanText.replace(/#/g, "") // Remove markdown headers
        cleanText = cleanText.replace(/\[.*?\]/g, "") // Remove markdown links
        cleanText = cleanText.replace(/\n+/g, " ") // Replace newlines with spaces
        cleanText = cleanText.trim()
        
        return cleanText
    }
    
    // 🌍 AUTOMATIC LANGUAGE DETECTION
    function detectLanguage(text) {
        if (!text || text.length === 0) return "en"
        
        // Count different character types
        var chineseChars = (text.match(/[\u4e00-\u9fff\u3400-\u4dbf]/g) || []).length
        var englishChars = (text.match(/[a-zA-Z]/g) || []).length
        var totalChars = text.replace(/\s/g, "").length
        
        console.log("📊 Language detection stats:")
        console.log("  Chinese chars:", chineseChars)
        console.log("  English chars:", englishChars)
        console.log("  Total chars:", totalChars)
        
        // Determine language based on character distribution
        if (totalChars === 0) return "en"
        
        var chineseRatio = chineseChars / totalChars
        var englishRatio = englishChars / totalChars
        
        console.log("  Chinese ratio:", chineseRatio.toFixed(2))
        console.log("  English ratio:", englishRatio.toFixed(2))
        
        // If more than 10% Chinese characters, consider it Chinese
        if (chineseRatio > 0.1) {
            return "zh"
        }
        // If more than 30% English characters, consider it English
        else if (englishRatio > 0.3) {
            return "en"
        }
        // Mixed or other language, default to English
        else {
            return "en"
        }
    }
    
    // 🔄 PROPER VOICE SWITCHING FOLLOWING Qt OFFICIAL EXAMPLES
    function switchToLanguageVoice(language) {
        console.log("🔍 Switching to", language, "voice using Qt example pattern")
        
        var targetLocale
        if (language === "zh") {
            targetLocale = Qt.locale("zh-CN") // Chinese (Simplified)
            console.log("🇨🇳 Setting locale to Chinese (zh-CN)")
        } else if (language === "en") {
            targetLocale = Qt.locale("en-US") // English (US)  
            console.log("🇺🇸 Setting locale to English (en-US)")
        } else {
            targetLocale = Qt.locale("en-US") // Default to English
            console.log("🌐 Unknown language, defaulting to English")
        }
        
        // Store current voice for comparison
        var previousVoice = tts.voice ? tts.voice.name : "none"
        var previousLocale = tts.locale ? tts.locale.name : "none"
        
        console.log("Previous locale:", previousLocale, "voice:", previousVoice)
        
        // Step 1: Set the locale (following Qt examples)
        tts.locale = targetLocale
        console.log("✅ Locale set to:", targetLocale.name)
        
        // Step 2: Get available voices for this locale
        var availableVoices = tts.availableVoices
        console.log("Available voices for", targetLocale.name + ":", availableVoices.length)
        
        // Log available voices for debugging
        for (var i = 0; i < Math.min(5, availableVoices.length); i++) {
            var voice = availableVoices[i]
            console.log("  Voice " + i + ":", voice.name, "(" + voice.locale.name + ")")
        }
        
        // Step 3: Set the first available voice for this locale (if any)
        if (availableVoices.length > 0) {
            var selectedVoice = availableVoices[0] // Use first available voice
            tts.voice = selectedVoice
            console.log("✅ Voice set to:", selectedVoice.name)
            return true
        } else {
            console.log("⚠️ No voices available for locale:", targetLocale.name)
            
            if (language === "zh") {
                console.log("💡 Chinese voices not installed. To install:")
                console.log("   1. Windows 10/11: Settings > Time & Language > Language")
                console.log("   2. Add Chinese (Simplified) or Chinese (Traditional)")
                console.log("   3. Install language pack with speech features")
                console.log("   4. Restart application")
            }
            return false
        }
    }
    
    // Enhanced pause function with boundary hints
    function pauseAtWord() {
        if (tts.engineCapabilities & TextToSpeech.PauseResume) {
            tts.pause(TextToSpeech.Word)
        }
    }
    
    function pauseAtSentence() {
        if (tts.engineCapabilities & TextToSpeech.PauseResume) {
            tts.pause(TextToSpeech.Sentence)
        }
    }

    

        // Internal helper functions - Enhanced with Qt 6.9 features
    function updateVoices() {
        console.log("updateVoices called - TTS state:", tts.state)
        console.log("Engine capabilities:", tts.engineCapabilities)
        
        var voices = tts.availableVoices
        console.log("Available voices count:", voices.length)
        
        var names = []
        for (var i = 0; i < voices.length; i++) {
            var voice = voices[i]
            var displayName = voice.name
            
            // Enhanced logging with all QVoice properties
            console.log("Voice", i + ":")
            console.log("  Name:", voice.name)
            console.log("  Gender:", voice.gender)
            console.log("  Age:", voice.age)
            console.log("  Locale:", voice.locale.name)
            
            // Create more informative display names using QVoice properties
            displayName += " ("
            
            // Gender information
            if (voice.gender === Voice.Male) {
                displayName += "Male"
            } else if (voice.gender === Voice.Female) {
                displayName += "Female"
            } else {
                displayName += "Unknown"
            }
            
            // Age information
            if (voice.age === Voice.Child) {
                displayName += ", Child"
            } else if (voice.age === Voice.Teenager) {
                displayName += ", Teen"
            } else if (voice.age === Voice.Adult) {
                displayName += ", Adult"
            } else if (voice.age === Voice.Senior) {
                displayName += ", Senior"
            } else {
                displayName += ", Adult"
            }
            
            // Locale information
            displayName += ", " + voice.locale.name + ")"
            
            names.push(displayName)
        }
        
        console.log("Final voice display names:", names)
        root.voiceDisplayNames = names
        
        console.log("Engine supports WordByWord:", (tts.engineCapabilities & TextToSpeech.WordByWordProgress))
        console.log("Engine supports PauseResume:", (tts.engineCapabilities & TextToSpeech.PauseResume))
        
        // Emit signal to notify UI
        voicesUpdated()
    }

    function findBestVoice(preference) {
        var voices = tts.availableVoices
        var bestVoice = null

        console.log("=== FINDING BEST VOICE ===")
        console.log("Preference:", preference)
        console.log("Available voices count:", voices.length)

        for (var i = 0; i < voices.length; i++) {
            var voice = voices[i]
            console.log("Voice", i + ":", voice.name, "Locale:", voice.locale.name, "Gender:", voice.gender)

            if (preference === "male" && voice.gender === Voice.Male) {
                bestVoice = voice
                break
            } else if (preference === "female" && voice.gender === Voice.Female) {
                bestVoice = voice
                break
            } else if (preference === "chinese" && (voice.locale.name.includes("zh") || voice.locale.name.includes("Chinese") || voice.name.toLowerCase().includes("chinese"))) {
                console.log("Found Chinese voice:", voice.name)
                bestVoice = voice
                break
            }
        }

        // Fallback to first available voice
        if (!bestVoice && voices.length > 0) {
            bestVoice = voices[0]
            console.log("No preferred voice found, using first available:", bestVoice.name)
        }

        if (bestVoice) {
            console.log("Setting best voice to:", bestVoice.name, "Locale:", bestVoice.locale.name)
            tts.voice = bestVoice
        } else {
            console.log("No voice found!")
        }
        console.log("=== END FIND BEST VOICE ===")
    }
    
    // Enhanced Chinese voice detection and selection
    function findChineseVoices() {
        var voices = tts.availableVoices
        var chineseVoices = []
        
        console.log("=== SEARCHING FOR CHINESE VOICES ===")
        
        for (var i = 0; i < voices.length; i++) {
            var voice = voices[i]
            var isChineseVoice = false
            
            // Check locale name for Chinese indicators
            if (voice.locale.name.toLowerCase().includes("zh") ||
                voice.locale.name.toLowerCase().includes("chinese") ||
                voice.locale.name.toLowerCase().includes("cn") ||
                voice.locale.name.toLowerCase().includes("tw") ||
                voice.locale.name.toLowerCase().includes("hk")) {
                isChineseVoice = true
            }
            
            // Check voice name for Chinese indicators
            if (voice.name.toLowerCase().includes("chinese") ||
                voice.name.toLowerCase().includes("mandarin") ||
                voice.name.toLowerCase().includes("cantonese") ||
                voice.name.toLowerCase().includes("huihui") ||
                voice.name.toLowerCase().includes("yaoyao") ||
                voice.name.toLowerCase().includes("kangkang")) {
                isChineseVoice = true
            }
            
            if (isChineseVoice) {
                console.log("🇨🇳 Found Chinese voice:", voice.name, "Locale:", voice.locale.name, "Gender:", voice.gender)
                chineseVoices.push(voice)
            }
        }
        
        console.log("Total Chinese voices found:", chineseVoices.length)
        console.log("=== END CHINESE VOICE SEARCH ===")
        
        return chineseVoices
    }
    
    // Set default Chinese voice if available
    function setChineseVoice() {
        var chineseVoices = findChineseVoices()
        
        if (chineseVoices.length > 0) {
            console.log("Setting Chinese voice:", chineseVoices[0].name)
            tts.voice = chineseVoices[0]
            return true
        } else {
            console.log("No Chinese voices available on this system")
            return false
        }
    }


}
