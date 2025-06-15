#include "VoiceRecognitionManager.h"
#include <QDebug>
#include <QThread>

// ============================================================================
// PLATFORM-SPECIFIC SPEECH RECOGNITION IMPLEMENTATIONS
// ============================================================================

void VoiceRecognitionManager::initializePlatformSpeechRecognition()
{
#ifdef Q_OS_WIN
    initializeWindowsSAPI();
#elif defined(Q_OS_ANDROID)
    initializeAndroidSpeechRecognition();
#elif defined(Q_OS_IOS)
    initializeIOSSpeechRecognition();
#elif defined(Q_OS_LINUX)
    initializeLinuxSpeechRecognition();
#else
    qWarning() << "Platform-specific speech recognition not implemented for this platform";
    m_useLocalSpeechRecognition = false;
#endif
}

void VoiceRecognitionManager::setupAudioProcessingThread()
{
    // Create dedicated thread for audio processing to prevent UI blocking
    m_audioProcessingThread = new QThread(this);
    m_audioProcessingThread->setObjectName("AudioProcessingThread");
    m_audioProcessingThread->start(QThread::HighPriority);
    
    qDebug() << "Audio processing thread created for better performance";
}

void VoiceRecognitionManager::processVoiceToTextLocal(const QByteArray &audioData)
{
    if (!m_useLocalSpeechRecognition || !isLocalSpeechRecognitionAvailable()) {
        // Fallback to Google Cloud Speech API
        sendToGoogleSpeechAPI(audioData);
        return;
    }
    
    QString recognizedText;
    
#ifdef Q_OS_WIN
    recognizedText = processWithWindowsSAPI(audioData);
#elif defined(Q_OS_ANDROID)
    recognizedText = processWithAndroidSpeechRecognition(audioData);
#elif defined(Q_OS_IOS)
    recognizedText = processWithIOSSpeechRecognition(audioData);
#elif defined(Q_OS_LINUX)
    recognizedText = processWithLinuxSpeechRecognition(audioData);
#endif
    
    if (!recognizedText.isEmpty()) {
        m_recognizedText = recognizedText;
        emit recognizedTextChanged();
        emit textRecognized(recognizedText);
        qDebug() << "Local speech recognition result:" << recognizedText;
    } else {
        // Fallback to cloud if local recognition fails
        qDebug() << "Local speech recognition failed, falling back to cloud";
        sendToGoogleSpeechAPI(audioData);
    }
}

bool VoiceRecognitionManager::isLocalSpeechRecognitionAvailable() const
{
#ifdef Q_OS_WIN
    return m_windowsSAPIRecognizer != nullptr;
#elif defined(Q_OS_ANDROID)
    return m_androidRecognizer != nullptr;
#elif defined(Q_OS_IOS)
    return true; // iOS Speech Framework is always available
#elif defined(Q_OS_LINUX)
    return false; // Would check for PocketSphinx/Vosk installation
#else
    return false;
#endif
}

// ============================================================================
// WINDOWS SAPI IMPLEMENTATION
// ============================================================================

#ifdef Q_OS_WIN
#include <windows.h>
#include <sapi.h>
#include <sphelper.h>
#include <comdef.h>

void VoiceRecognitionManager::initializeWindowsSAPI()
{
    HRESULT hr = CoInitialize(nullptr);
    if (FAILED(hr)) {
        qWarning() << "Failed to initialize COM for Windows SAPI";
        m_windowsSAPIRecognizer = nullptr;
        return;
    }
    
    ISpRecoContext *recoContext = nullptr;
    hr = CoCreateInstance(CLSID_SpInprocRecognizer, nullptr, CLSCTX_ALL,
                         IID_ISpRecoContext, (void**)&recoContext);
    
    if (SUCCEEDED(hr) && recoContext) {
        // Configure recognition context for better performance
        ISpRecoGrammar *grammar = nullptr;
        hr = recoContext->CreateGrammar(0, &grammar);
        
        if (SUCCEEDED(hr) && grammar) {
            // Load dictation grammar for general speech recognition
            grammar->LoadDictation(nullptr, SPLO_STATIC);
            grammar->SetDictationState(SPRS_ACTIVE);
            
            // Optimize for real-time recognition
            recoContext->SetMaxAlternates(1);
            recoContext->SetAudioOptions(SPAO_RETAIN_AUDIO, nullptr, nullptr);
            
            grammar->Release();
        }
        
        m_windowsSAPIRecognizer = recoContext;
        m_useLocalSpeechRecognition = true;
        qDebug() << "Windows SAPI initialized successfully with performance optimizations";
    } else {
        qWarning() << "Failed to initialize Windows SAPI";
        m_windowsSAPIRecognizer = nullptr;
        m_useLocalSpeechRecognition = false;
    }
}

QString VoiceRecognitionManager::processWithWindowsSAPI(const QByteArray &audioData)
{
    Q_UNUSED(audioData) // For now, we'll use microphone input instead of processing raw audio data
    
    if (!m_windowsSAPIRecognizer) return QString();
    
    ISpRecoContext *recoContext = static_cast<ISpRecoContext*>(m_windowsSAPIRecognizer);
    
    try {
        // Set up recognition for a single utterance
        HRESULT hr = recoContext->SetInterest(SPFEI(SPEI_RECOGNITION) | SPFEI(SPEI_FALSE_RECOGNITION), 
                                           SPFEI(SPEI_RECOGNITION) | SPFEI(SPEI_FALSE_RECOGNITION));
        
        if (SUCCEEDED(hr)) {
            // Start recognition (it will use the default microphone input already configured)
            hr = recoContext->Resume(0);
            
            if (SUCCEEDED(hr)) {
                // Wait for recognition events
                SPEVENT speechEvent;
                ULONG eventsFetched = 0;
                
                // Simple polling for recognition events (with timeout)
                int timeoutCounter = 0;
                const int maxTimeout = 50; // 5 seconds at 100ms intervals
                
                while (timeoutCounter < maxTimeout) {
                    hr = recoContext->GetEvents(1, &speechEvent, &eventsFetched);
                    
                    if (SUCCEEDED(hr) && eventsFetched > 0) {
                        if (speechEvent.eEventId == SPEI_RECOGNITION) {
                            ISpRecoResult *result = reinterpret_cast<ISpRecoResult*>(speechEvent.lParam);
                            if (result) {
                                WCHAR *pwszText = nullptr;
                                hr = result->GetText(SP_GETWHOLEPHRASE, SP_GETWHOLEPHRASE, FALSE, &pwszText, nullptr);
                                
                                if (SUCCEEDED(hr) && pwszText) {
                                    QString recognizedText = QString::fromWCharArray(pwszText);
                                    CoTaskMemFree(pwszText);
                                    result->Release();
                                    return recognizedText;
                                }
                                result->Release();
                            }
                        }
                    }
                    
                    // Brief sleep to avoid busy waiting
                    Sleep(100);
                    timeoutCounter++;
                }
            }
        }
    } catch (...) {
        qWarning() << "Exception in Windows SAPI processing";
    }
    
    return QString(); // Return empty on failure or timeout
}
#endif

// ============================================================================
// ANDROID IMPLEMENTATION  
// ============================================================================

#ifdef Q_OS_ANDROID
#include <QJniObject>
#include <QJniEnvironment>

void VoiceRecognitionManager::initializeAndroidSpeechRecognition()
{
    qDebug() << "Initializing Android Speech Recognition with JNI integration";
    
    try {
        // Qt6.9 handles Android permissions automatically via AndroidManifest.xml
        qDebug() << "Android Speech Recognition: Using Qt6.9 automatic permission handling";
        
        // Get Android context
        QJniObject activity = QJniObject::callStaticObjectMethod(
            "org/qtproject/qt/android/QtNative", "activity", "()Landroid/app/Activity;");
        
        if (!activity.isValid()) {
            qWarning() << "Cannot get Android activity for speech recognition";
            m_useLocalSpeechRecognition = false;
            return;
        }
        
        // Check if SpeechRecognizer is available
        QJniObject speechRecognizer = QJniObject::callStaticObjectMethod(
            "android/speech/SpeechRecognizer", "isRecognitionAvailable",
            "(Landroid/content/Context;)Z", activity.object<jobject>());
        
        if (!speechRecognizer.isValid()) {
            qWarning() << "SpeechRecognizer not available on this Android device";
            m_useLocalSpeechRecognition = false;
            return;
        }
        
        // Create SpeechRecognizer instance
        QJniObject recognizer = QJniObject::callStaticObjectMethod(
            "android/speech/SpeechRecognizer", "createSpeechRecognizer",
            "(Landroid/content/Context;)Landroid/speech/SpeechRecognizer;",
            activity.object<jobject>());
        
        if (recognizer.isValid()) {
            m_androidRecognizer = recognizer;
            m_useLocalSpeechRecognition = true;
            qDebug() << "Android Speech Recognition initialized successfully";
            
            // Set up recognition intent template
            setupAndroidRecognitionIntent();
        } else {
            qWarning() << "Failed to create Android SpeechRecognizer instance";
            m_useLocalSpeechRecognition = false;
        }
        
    } catch (...) {
        qWarning() << "Exception during Android Speech Recognition initialization";
        m_useLocalSpeechRecognition = false;
    }
}

void VoiceRecognitionManager::setupAndroidRecognitionIntent()
{
    try {
        // Create recognition intent
        QJniObject intent = QJniObject("android/content/Intent",
                                       "(Ljava/lang/String;)V",
                                       QJniObject::getStaticObjectField("android/speech/RecognizerIntent",
                                                                        "ACTION_RECOGNIZE_SPEECH",
                                                                        "Ljava/lang/String;").object<jstring>());
        
        // Set language model
        intent.callMethod<jobject>("putExtra",
                                   "(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;",
                                   QJniObject::getStaticObjectField("android/speech/RecognizerIntent",
                                                                    "EXTRA_LANGUAGE_MODEL",
                                                                    "Ljava/lang/String;").object<jstring>(),
                                   QJniObject::getStaticObjectField("android/speech/RecognizerIntent",
                                                                    "LANGUAGE_MODEL_FREE_FORM",
                                                                    "Ljava/lang/String;").object<jstring>());
        
        // Set language
        intent.callMethod<jobject>("putExtra",
                                   "(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;",
                                   QJniObject::getStaticObjectField("android/speech/RecognizerIntent",
                                                                    "EXTRA_LANGUAGE",
                                                                    "Ljava/lang/String;").object<jstring>(),
                                   QJniObject::fromString("en-US").object<jstring>());
        
        // Set max results
        intent.callMethod<jobject>("putExtra",
                                   "(Ljava/lang/String;I)Landroid/content/Intent;",
                                   QJniObject::getStaticObjectField("android/speech/RecognizerIntent",
                                                                    "EXTRA_MAX_RESULTS",
                                                                    "Ljava/lang/String;").object<jstring>(),
                                   1);
        
        // Set partial results
        intent.callMethod<jobject>("putExtra",
                                   "(Ljava/lang/String;Z)Landroid/content/Intent;",
                                   QJniObject::getStaticObjectField("android/speech/RecognizerIntent",
                                                                    "EXTRA_PARTIAL_RESULTS",
                                                                    "Ljava/lang/String;").object<jstring>(),
                                   true);
        
        m_androidRecognitionIntent = intent;
        qDebug() << "Android recognition intent configured";
        
    } catch (...) {
        qWarning() << "Exception setting up Android recognition intent";
    }
}

QString VoiceRecognitionManager::processWithAndroidSpeechRecognition(const QByteArray &audioData)
{
    Q_UNUSED(audioData) // Android SpeechRecognizer uses microphone directly
    
    if (!m_androidRecognizer.isValid() || !m_androidRecognitionIntent.isValid()) {
        qWarning() << "Android Speech Recognition not properly initialized";
        return QString();
    }
    
    try {
        // Qt6.9 handles permissions automatically - no need to check manually
        
        // Start listening using the prepared intent
        m_androidRecognizer.callMethod<void>("startListening",
                                             "(Landroid/content/Intent;)V",
                                             m_androidRecognitionIntent.object<jobject>());
        
        // Note: In a real implementation, this would be asynchronous
        // Results would come through RecognitionListener callbacks
        // For now, we'll use a simplified synchronous approach with timeout
        
        // Wait for results (simplified implementation)
        QThread::msleep(3000); // 3 second timeout
        
        // In a full implementation, results would be stored in member variables
        // by the RecognitionListener callbacks
        if (!m_lastAndroidRecognitionResult.isEmpty()) {
            QString result = m_lastAndroidRecognitionResult;
            m_lastAndroidRecognitionResult.clear();
            return result;
        }
        
        qDebug() << "Android Speech Recognition completed with no results";
        return QString();
        
    } catch (...) {
        qWarning() << "Exception during Android Speech Recognition processing";
        return QString();
    }
}

// JNI callback for Android speech recognition results
extern "C" JNIEXPORT void JNICALL
Java_com_voiceaillm_app_SpeechRecognitionHelper_onRecognitionResults(JNIEnv *env, jobject thiz,
                                                                     jobjectArray results)
{
    Q_UNUSED(thiz)
    
    if (!results) return;
    
    // Get the first result (best match)
    jsize resultCount = env->GetArrayLength(results);
    if (resultCount > 0) {
        jstring firstResult = (jstring)env->GetObjectArrayElement(results, 0);
        if (firstResult) {
            const char *nativeString = env->GetStringUTFChars(firstResult, 0);
            QString recognizedText = QString::fromUtf8(nativeString);
            
            // Store result in manager (would need to get instance reference)
            // For now, we'll log it
            qDebug() << "Android Speech Recognition result:" << recognizedText;
            
            env->ReleaseStringUTFChars(firstResult, nativeString);
            env->DeleteLocalRef(firstResult);
        }
    }
}
#endif

// ============================================================================
// iOS IMPLEMENTATION
// ============================================================================

#ifdef Q_OS_IOS
void VoiceRecognitionManager::initializeIOSSpeechRecognition()
{
    // iOS implementation would use Objective-C++ to interface with Speech Framework
    // SFSpeechRecognizer and SFSpeechAudioBufferRecognitionRequest
    qDebug() << "iOS Speech Recognition initialization";
    
    // In a full implementation:
    // 1. Request speech recognition authorization
    // 2. Create SFSpeechRecognizer for locale
    // 3. Check availability and authorization status
    // 4. Set up for real-time recognition
    
    m_useLocalSpeechRecognition = false; // Set to true when implemented
    
    qWarning() << "iOS Speech Recognition requires Speech Framework implementation";
}

QString VoiceRecognitionManager::processWithIOSSpeechRecognition(const QByteArray &audioData)
{
    Q_UNUSED(audioData)
    
    // iOS implementation would:
    // 1. Convert QByteArray to AVAudioPCMBuffer
    // 2. Create SFSpeechAudioBufferRecognitionRequest
    // 3. Append audio buffer to request
    // 4. Process with SFSpeechRecognizer
    // 5. Return best transcription
    
    qWarning() << "iOS Speech Recognition processing not implemented";
    return QString();
}
#endif

// ============================================================================
// LINUX IMPLEMENTATION
// ============================================================================

#ifdef Q_OS_LINUX
void VoiceRecognitionManager::initializeLinuxSpeechRecognition()
{
    // Linux implementation could use:
    // 1. PocketSphinx for offline recognition
    // 2. Vosk for better accuracy
    // 3. Mozilla DeepSpeech
    // 4. Wav2Vec2 models
    
    qDebug() << "Linux Speech Recognition initialization";
    
    // Check for available speech recognition libraries
    // This would require linking against chosen library
    
    m_useLocalSpeechRecognition = false; // Set to true when library is available
    
    qWarning() << "Linux Speech Recognition requires PocketSphinx/Vosk/DeepSpeech implementation";
}

QString VoiceRecognitionManager::processWithLinuxSpeechRecognition(const QByteArray &audioData)
{
    Q_UNUSED(audioData)
    
    // Linux implementation example with PocketSphinx:
    // 1. Initialize ps_decoder_t with acoustic model
    // 2. Convert QByteArray to 16kHz 16-bit format
    // 3. Process audio frames with ps_process_raw()
    // 4. Get hypothesis with ps_get_hyp()
    // 5. Return recognized text
    
    qWarning() << "Linux Speech Recognition processing not implemented";
    return QString();
}
#endif 