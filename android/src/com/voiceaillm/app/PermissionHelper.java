package com.voiceaillm.app;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

public class PermissionHelper {
    private static final String TAG = "VoiceAILLM_Permissions";
    
    // Permission request codes
    public static final int AUDIO_PERMISSION_REQUEST = 1000;
    public static final int STORAGE_PERMISSION_REQUEST = 1001;
    public static final int ALL_PERMISSIONS_REQUEST = 1002;
    
    // Required permissions
    public static final String[] AUDIO_PERMISSIONS = {
        android.Manifest.permission.RECORD_AUDIO
    };
    
    public static final String[] STORAGE_PERMISSIONS = {
        android.Manifest.permission.WRITE_EXTERNAL_STORAGE,
        android.Manifest.permission.READ_EXTERNAL_STORAGE
    };
    
    public static final String[] ALL_PERMISSIONS = {
        android.Manifest.permission.RECORD_AUDIO,
        android.Manifest.permission.WRITE_EXTERNAL_STORAGE,
        android.Manifest.permission.READ_EXTERNAL_STORAGE,
        android.Manifest.permission.INTERNET,
        android.Manifest.permission.ACCESS_NETWORK_STATE,
        android.Manifest.permission.WAKE_LOCK
    };
    
    private static Activity m_activity;
    
    public static void setActivity(Activity activity) {
        m_activity = activity;
        Log.d(TAG, "Activity set for permission management");
    }
    
    /**
     * Check if a specific permission is granted
     */
    public static boolean hasPermission(Context context, String permission) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true; // Permissions are granted at install time for API < 23
        }
        
        boolean granted = ContextCompat.checkSelfPermission(context, permission) == PackageManager.PERMISSION_GRANTED;
        Log.d(TAG, "Permission " + permission + " status: " + (granted ? "GRANTED" : "DENIED"));
        return granted;
    }
    
    /**
     * Check if all permissions in an array are granted
     */
    public static boolean hasAllPermissions(Context context, String[] permissions) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true;
        }
        
        for (String permission : permissions) {
            if (!hasPermission(context, permission)) {
                return false;
            }
        }
        return true;
    }
    
    /**
     * Request a single permission
     */
    public static void requestPermission(String permission, int requestCode) {
        if (m_activity == null) {
            Log.e(TAG, "Activity not set, cannot request permission");
            return;
        }
        
        Log.d(TAG, "Requesting permission: " + permission);
        ActivityCompat.requestPermissions(m_activity, new String[]{permission}, requestCode);
    }
    
    /**
     * Request multiple permissions
     */
    public static void requestPermissions(String[] permissions, int requestCode) {
        if (m_activity == null) {
            Log.e(TAG, "Activity not set, cannot request permissions");
            return;
        }
        
        Log.d(TAG, "Requesting " + permissions.length + " permissions");
        for (String permission : permissions) {
            Log.d(TAG, "  - " + permission);
        }
        
        ActivityCompat.requestPermissions(m_activity, permissions, requestCode);
    }
    
    /**
     * Request audio permission
     */
    public static void requestAudioPermission() {
        requestPermissions(AUDIO_PERMISSIONS, AUDIO_PERMISSION_REQUEST);
    }
    
    /**
     * Request storage permissions
     */
    public static void requestStoragePermissions() {
        requestPermissions(STORAGE_PERMISSIONS, STORAGE_PERMISSION_REQUEST);
    }
    
    /**
     * Request all app permissions
     */
    public static void requestAllPermissions() {
        requestPermissions(ALL_PERMISSIONS, ALL_PERMISSIONS_REQUEST);
    }
    
    /**
     * Check audio permission status
     */
    public static boolean hasAudioPermission(Context context) {
        return hasAllPermissions(context, AUDIO_PERMISSIONS);
    }
    
    /**
     * Check storage permission status
     */
    public static boolean hasStoragePermission(Context context) {
        return hasAllPermissions(context, STORAGE_PERMISSIONS);
    }
    
    /**
     * Check if permission should show rationale
     */
    public static boolean shouldShowRequestPermissionRationale(String permission) {
        if (m_activity == null) {
            return false;
        }
        return ActivityCompat.shouldShowRequestPermissionRationale(m_activity, permission);
    }
    
    /**
     * Handle permission result - called from Qt C++ code
     */
    public static void onPermissionResult(int requestCode, String[] permissions, int[] grantResults) {
        Log.d(TAG, "Permission result received - Request code: " + requestCode);
        
        StringBuilder result = new StringBuilder();
        result.append("Permissions result:\n");
        
        for (int i = 0; i < permissions.length && i < grantResults.length; i++) {
            boolean granted = grantResults[i] == PackageManager.PERMISSION_GRANTED;
            result.append("  ").append(permissions[i]).append(": ").append(granted ? "GRANTED" : "DENIED").append("\n");
            
            // Call native callback for each permission
            notifyPermissionResult(permissions[i], granted);
        }
        
        Log.d(TAG, result.toString());
        
        // Call native callback with all results
        notifyPermissionResults(requestCode, permissions, grantResults);
    }
    
    // Native methods - implemented in C++
    public static native void notifyPermissionResult(String permission, boolean granted);
    public static native void notifyPermissionResults(int requestCode, String[] permissions, int[] grantResults);
    
    /**
     * Initialize permission helper
     */
    public static void initialize(Activity activity) {
        setActivity(activity);
        Log.d(TAG, "PermissionHelper initialized");
        
        // Log current permission status
        Context context = activity.getApplicationContext();
        Log.d(TAG, "Current permission status:");
        Log.d(TAG, "  Audio: " + hasAudioPermission(context));
        Log.d(TAG, "  Storage: " + hasStoragePermission(context));
    }
    
    /**
     * Get permission status summary
     */
    public static String getPermissionStatusSummary(Context context) {
        StringBuilder status = new StringBuilder();
        status.append("Permission Status Summary:\n");
        status.append("Audio: ").append(hasAudioPermission(context) ? "✓ GRANTED" : "✗ DENIED").append("\n");
        status.append("Storage: ").append(hasStoragePermission(context) ? "✓ GRANTED" : "✗ DENIED").append("\n");
        status.append("SDK Version: ").append(Build.VERSION.SDK_INT).append("\n");
        
        return status.toString();
    }
} 