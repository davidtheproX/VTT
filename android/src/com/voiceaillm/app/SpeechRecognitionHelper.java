package com.voiceaillm.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.util.Log;
import java.util.ArrayList;
import java.util.Locale;

public class SpeechRecognitionHelper implements RecognitionListener {
    private static final String TAG = "VoiceAILLM_Speech";
    
    private static SpeechRecognizer speechRecognizer;
    private static Activity m_activity;
    private static SpeechRecognitionHelper instance;
    private static boolean isListening = false;
    
    // Speech recognition configuration
    private static final String LANGUAGE = "en-US";
    private static final int MAX_RESULTS = 5;
    private static final boolean USE_PARTIAL_RESULTS = true;
    
    // Recognition states
    public static final int STATE_READY = 0;
    public static final int STATE_LISTENING = 1;
    public static final int STATE_PROCESSING = 2;
    public static final int STATE_ERROR = 3;
    
    private static int currentState = STATE_READY;
    
    public static void setActivity(Activity activity) {
        m_activity = activity;
        Log.d(TAG, "Activity set for speech recognition");
    }
    
    /**
     * Initialize speech recognition
     */
    public static boolean initialize(Activity activity) {
        setActivity(activity);
        
        if (!SpeechRecognizer.isRecognitionAvailable(activity)) {
            Log.e(TAG, "Speech recognition not available on this device");
            return false;
        }
        
        try {
            // Create speech recognizer
            speechRecognizer = SpeechRecognizer.createSpeechRecognizer(activity);
            if (speechRecognizer == null) {
                Log.e(TAG, "Failed to create SpeechRecognizer");
                return false;
            }
            
            // Create and set listener instance
            instance = new SpeechRecognitionHelper();
            speechRecognizer.setRecognitionListener(instance);
            
            Log.d(TAG, "Speech recognition initialized successfully");
            return true;
            
        } catch (Exception e) {
            Log.e(TAG, "Exception during speech recognition initialization", e);
            return false;
        }
    }
    
    /**
     * Start speech recognition
     */
    public static boolean startListening() {
        if (speechRecognizer == null || m_activity == null) {
            Log.e(TAG, "Speech recognition not initialized");
            return false;
        }
        
        if (isListening) {
            Log.w(TAG, "Already listening");
            return true;
        }
        
        try {
            // Create recognition intent
            Intent intent = createRecognitionIntent();
            
            // Start listening
            speechRecognizer.startListening(intent);
            isListening = true;
            currentState = STATE_LISTENING;
            
            Log.d(TAG, "Started speech recognition");
            notifyStateChanged(STATE_LISTENING);
            return true;
            
        } catch (Exception e) {
            Log.e(TAG, "Exception starting speech recognition", e);
            currentState = STATE_ERROR;
            notifyStateChanged(STATE_ERROR);
            return false;
        }
    }
    
    /**
     * Stop speech recognition
     */
    public static void stopListening() {
        if (speechRecognizer != null && isListening) {
            try {
                speechRecognizer.stopListening();
                Log.d(TAG, "Stopped speech recognition");
            } catch (Exception e) {
                Log.e(TAG, "Exception stopping speech recognition", e);
            }
        }
        isListening = false;
        currentState = STATE_READY;
        notifyStateChanged(STATE_READY);
    }
    
    /**
     * Cancel speech recognition
     */
    public static void cancel() {
        if (speechRecognizer != null) {
            try {
                speechRecognizer.cancel();
                Log.d(TAG, "Cancelled speech recognition");
            } catch (Exception e) {
                Log.e(TAG, "Exception cancelling speech recognition", e);
            }
        }
        isListening = false;
        currentState = STATE_READY;
        notifyStateChanged(STATE_READY);
    }
    
    /**
     * Destroy speech recognition resources
     */
    public static void destroy() {
        if (speechRecognizer != null) {
            try {
                speechRecognizer.destroy();
                Log.d(TAG, "Speech recognition destroyed");
            } catch (Exception e) {
                Log.e(TAG, "Exception destroying speech recognition", e);
            }
            speechRecognizer = null;
        }
        instance = null;
        isListening = false;
        currentState = STATE_READY;
    }
    
    /**
     * Create recognition intent with optimized settings
     */
    private static Intent createRecognitionIntent() {
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        
        // Set language model for free-form speech
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, 
                       RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        
        // Set language (can be made configurable)
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, LANGUAGE);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_PREFERENCE, LANGUAGE);
        
        // Set number of results
        intent.putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, MAX_RESULTS);
        
        // Enable partial results for real-time feedback
        intent.putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, USE_PARTIAL_RESULTS);
        
        // Optimize for voice command recognition
        intent.putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_COMPLETE_SILENCE_LENGTH_MILLIS, 1500);
        intent.putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_POSSIBLY_COMPLETE_SILENCE_LENGTH_MILLIS, 1500);
        intent.putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_MINIMUM_LENGTH_MILLIS, 15000);
        
        // Set calling package
        intent.putExtra(RecognizerIntent.EXTRA_CALLING_PACKAGE, m_activity.getPackageName());
        
        return intent;
    }
    
    /**
     * Check if currently listening
     */
    public static boolean isListening() {
        return isListening;
    }
    
    /**
     * Get current recognition state
     */
    public static int getCurrentState() {
        return currentState;
    }
    
    // RecognitionListener implementation
    
    @Override
    public void onReadyForSpeech(Bundle params) {
        Log.d(TAG, "Ready for speech");
        currentState = STATE_LISTENING;
        notifyStateChanged(STATE_LISTENING);
        notifyReadyForSpeech();
    }
    
    @Override
    public void onBeginningOfSpeech() {
        Log.d(TAG, "Beginning of speech detected");
        notifyBeginningOfSpeech();
    }
    
    @Override
    public void onRmsChanged(float rmsdB) {
        // Audio level feedback for UI
        notifyAudioLevelChanged(rmsdB);
    }
    
    @Override
    public void onBufferReceived(byte[] buffer) {
        Log.v(TAG, "Audio buffer received: " + buffer.length + " bytes");
    }
    
    @Override
    public void onEndOfSpeech() {
        Log.d(TAG, "End of speech");
        currentState = STATE_PROCESSING;
        notifyStateChanged(STATE_PROCESSING);
        notifyEndOfSpeech();
    }
    
    @Override
    public void onError(int error) {
        String errorMessage = getErrorMessage(error);
        Log.e(TAG, "Recognition error: " + errorMessage + " (code: " + error + ")");
        
        isListening = false;
        currentState = STATE_ERROR;
        notifyStateChanged(STATE_ERROR);
        notifyError(error, errorMessage);
    }
    
    @Override
    public void onResults(Bundle results) {
        Log.d(TAG, "Recognition results received");
        
        ArrayList<String> matches = results.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
        float[] confidenceScores = results.getFloatArray(SpeechRecognizer.CONFIDENCE_SCORES);
        
        if (matches != null && !matches.isEmpty()) {
            String bestMatch = matches.get(0);
            float confidence = (confidenceScores != null && confidenceScores.length > 0) ? 
                             confidenceScores[0] : 1.0f;
            
            Log.d(TAG, "Best recognition result: '" + bestMatch + "' (confidence: " + confidence + ")");
            
            // Convert to array for JNI callback
            String[] resultArray = matches.toArray(new String[matches.size()]);
            onRecognitionResults(resultArray);
            notifyResults(bestMatch, confidence, resultArray);
        } else {
            Log.w(TAG, "No recognition results");
            notifyNoResults();
        }
        
        isListening = false;
        currentState = STATE_READY;
        notifyStateChanged(STATE_READY);
    }
    
    @Override
    public void onPartialResults(Bundle partialResults) {
        ArrayList<String> matches = partialResults.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
        if (matches != null && !matches.isEmpty()) {
            String partialResult = matches.get(0);
            Log.d(TAG, "Partial result: " + partialResult);
            notifyPartialResults(partialResult);
        }
    }
    
    @Override
    public void onEvent(int eventType, Bundle params) {
        Log.v(TAG, "Recognition event: " + eventType);
    }
    
    /**
     * Convert error code to human-readable message
     */
    private String getErrorMessage(int error) {
        switch (error) {
            case SpeechRecognizer.ERROR_AUDIO:
                return "Audio recording error";
            case SpeechRecognizer.ERROR_CLIENT:
                return "Client side error";
            case SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS:
                return "Insufficient permissions";
            case SpeechRecognizer.ERROR_NETWORK:
                return "Network error";
            case SpeechRecognizer.ERROR_NETWORK_TIMEOUT:
                return "Network timeout";
            case SpeechRecognizer.ERROR_NO_MATCH:
                return "No speech match found";
            case SpeechRecognizer.ERROR_RECOGNIZER_BUSY:
                return "Speech recognizer busy";
            case SpeechRecognizer.ERROR_SERVER:
                return "Server error";
            case SpeechRecognizer.ERROR_SPEECH_TIMEOUT:
                return "Speech input timeout";
            default:
                return "Unknown error (" + error + ")";
        }
    }
    
    // Native method callbacks (implemented in C++)
    public static native void notifyStateChanged(int state);
    public static native void notifyReadyForSpeech();
    public static native void notifyBeginningOfSpeech();
    public static native void notifyEndOfSpeech();
    public static native void notifyAudioLevelChanged(float level);
    public static native void notifyError(int error, String message);
    public static native void notifyResults(String bestResult, float confidence, String[] allResults);
    public static native void notifyPartialResults(String partialResult);
    public static native void notifyNoResults();
    
    // This method is called from C++ (from the previous implementation)
    public static void onRecognitionResults(String[] results) {
        if (results != null && results.length > 0) {
            Log.d(TAG, "JNI callback - Recognition results: " + results[0]);
            // This bridges the gap between the old implementation and new one
        }
    }
} 