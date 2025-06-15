package com.voiceaillm.app;

import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyProperties;
import android.util.Log;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.InvalidAlgorithmParameterException;
import java.io.IOException;
import java.security.cert.CertificateException;
import java.security.UnrecoverableKeyException;

public class KeystoreHelper {
    private static final String TAG = "KeystoreHelper";
    private static final String KEYSTORE_PROVIDER = "AndroidKeyStore";
    private static final String KEY_ALGORITHM = KeyProperties.KEY_ALGORITHM_AES;
    private static final String TRANSFORMATION = KeyProperties.KEY_ALGORITHM_AES + "/" +
            KeyProperties.BLOCK_MODE_GCM + "/" + KeyProperties.ENCRYPTION_PADDING_NONE;
    private static final int KEY_SIZE = 256;
    
    private KeyStore mKeyStore;
    
    public KeystoreHelper() {
        try {
            mKeyStore = KeyStore.getInstance(KEYSTORE_PROVIDER);
            mKeyStore.load(null);
            Log.d(TAG, "Android Keystore initialized successfully");
        } catch (Exception e) {
            Log.e(TAG, "Failed to initialize Android Keystore", e);
            mKeyStore = null;
        }
    }
    
    public boolean isKeystoreAvailable() {
        return mKeyStore != null;
    }
    
    public boolean generateKey(String alias) {
        if (mKeyStore == null) {
            Log.e(TAG, "Keystore not available");
            onKeystoreResult("generateKey", alias, false, "Keystore not available");
            return false;
        }
        
        try {
            // Check if key already exists
            if (mKeyStore.containsAlias(alias)) {
                Log.d(TAG, "Key already exists for alias: " + alias);
                onKeystoreResult("generateKey", alias, true, null);
                return true;
            }
            
            KeyGenerator keyGenerator = KeyGenerator.getInstance(KEY_ALGORITHM, KEYSTORE_PROVIDER);
            
            KeyGenParameterSpec keyGenParameterSpec = new KeyGenParameterSpec.Builder(alias,
                    KeyProperties.PURPOSE_ENCRYPT | KeyProperties.PURPOSE_DECRYPT)
                    .setBlockModes(KeyProperties.BLOCK_MODE_GCM)
                    .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE)
                    .setKeySize(KEY_SIZE)
                    .setUserAuthenticationRequired(false) // For now, don't require user auth
                    .build();
            
            keyGenerator.init(keyGenParameterSpec);
            SecretKey secretKey = keyGenerator.generateKey();
            
            if (secretKey != null) {
                Log.d(TAG, "Successfully generated key for alias: " + alias);
                onKeystoreResult("generateKey", alias, true, null);
                return true;
            } else {
                Log.e(TAG, "Failed to generate key for alias: " + alias);
                onKeystoreResult("generateKey", alias, false, "Key generation returned null");
                return false;
            }
            
        } catch (NoSuchAlgorithmException | NoSuchProviderException | 
                 InvalidAlgorithmParameterException e) {
            Log.e(TAG, "Exception generating key for alias: " + alias, e);
            onKeystoreResult("generateKey", alias, false, e.getMessage());
            return false;
        }
    }
    
    public boolean deleteKey(String alias) {
        if (mKeyStore == null) {
            Log.e(TAG, "Keystore not available");
            onKeystoreResult("deleteKey", alias, false, "Keystore not available");
            return false;
        }
        
        try {
            if (mKeyStore.containsAlias(alias)) {
                mKeyStore.deleteEntry(alias);
                Log.d(TAG, "Successfully deleted key for alias: " + alias);
                onKeystoreResult("deleteKey", alias, true, null);
                return true;
            } else {
                Log.d(TAG, "No key found for alias: " + alias);
                onKeystoreResult("deleteKey", alias, true, null);
                return true;
            }
        } catch (KeyStoreException e) {
            Log.e(TAG, "Exception deleting key for alias: " + alias, e);
            onKeystoreResult("deleteKey", alias, false, e.getMessage());
            return false;
        }
    }
    
    public boolean hasKey(String alias) {
        if (mKeyStore == null) {
            return false;
        }
        
        try {
            return mKeyStore.containsAlias(alias);
        } catch (KeyStoreException e) {
            Log.e(TAG, "Exception checking key existence for alias: " + alias, e);
            return false;
        }
    }
    
    public SecretKey getKey(String alias) {
        if (mKeyStore == null) {
            Log.e(TAG, "Keystore not available");
            return null;
        }
        
        try {
            return (SecretKey) mKeyStore.getKey(alias, null);
        } catch (KeyStoreException | NoSuchAlgorithmException | UnrecoverableKeyException e) {
            Log.e(TAG, "Exception getting key for alias: " + alias, e);
            return null;
        }
    }
    
    public String[] listAliases() {
        if (mKeyStore == null) {
            return new String[0];
        }
        
        try {
            java.util.Enumeration<String> aliases = mKeyStore.aliases();
            java.util.List<String> aliasList = new java.util.ArrayList<>();
            while (aliases.hasMoreElements()) {
                aliasList.add(aliases.nextElement());
            }
            return aliasList.toArray(new String[0]);
        } catch (KeyStoreException e) {
            Log.e(TAG, "Exception listing aliases", e);
            return new String[0];
        }
    }
    
    // Native callback method - called from JNI
    private native void onKeystoreResult(String operation, String alias, boolean success, String error);
} 