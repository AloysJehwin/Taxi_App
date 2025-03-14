package com.aloysjehwin.taxiApp;

import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import javax.crypto.Cipher;

public class RSAUtility {

    private static final String ALGORITHM = "RSA";

    /**
     * Generate RSA key pair
     *
     * @param keySize the size of the key (e.g., 2048)
     * @return a KeyPair containing the public and private keys
     * @throws NoSuchAlgorithmException if RSA algorithm is not available
     */
    public static KeyPair generateKeyPair(int keySize) throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(ALGORITHM);
        keyPairGenerator.initialize(keySize);
        return keyPairGenerator.generateKeyPair();
    }

    /**
     * Encrypt a message using a public key
     *
     * @param plainText the message to encrypt
     * @param publicKey the public key
     * @return the encrypted message as a Base64-encoded string
     * @throws Exception if encryption fails
     */
    public static String encrypt(String plainText, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    /**
     * Decrypt a message using a private key
     *
     * @param encryptedText the encrypted message (Base64-encoded)
     * @param privateKey    the private key
     * @return the decrypted message
     * @throws Exception if decryption fails
     */
    public static String decrypt(String encryptedText, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
        return new String(decryptedBytes);
    }

    /**
     * Convert a public key to a Base64-encoded string
     *
     * @param publicKey the public key
     * @return the Base64-encoded string
     */
    public static String publicKeyToString(PublicKey publicKey) {
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }

    /**
     * Convert a private key to a Base64-encoded string
     *
     * @param privateKey the private key
     * @return the Base64-encoded string
     */
    public static String privateKeyToString(PrivateKey privateKey) {
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }

    /**
     * Convert a Base64-encoded string to a PublicKey
     *
     * @param publicKeyString the Base64-encoded string
     * @return the PublicKey
     * @throws Exception if conversion fails
     */
    public static PublicKey stringToPublicKey(String publicKeyString) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(publicKeyString);
        X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePublic(spec);
    }

    /**
     * Convert a Base64-encoded string to a PrivateKey
     *
     * @param privateKeyString the Base64-encoded string
     * @return the PrivateKey
     * @throws Exception if conversion fails
     */
    public static PrivateKey stringToPrivateKey(String privateKeyString) throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(privateKeyString);
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
        return keyFactory.generatePrivate(spec);
    }
    
    public static String decryptPrivateKey(String encryptedPrivateKeyBase64) {
        try {
            byte[] decodedKey = Base64.getDecoder().decode(encryptedPrivateKeyBase64);
            // Implement the actual decryption logic here (if required)
            // For example, if it was encrypted with a symmetric key:
            // Decrypt the decodedKey and return the result as a string
            return new String(decodedKey); // Assuming it's a simple Base64 decoded private key.
        } catch (Exception e) {
            e.printStackTrace();
            return null; // Return null or some error message if decryption fails
        }
    }
    
    public static String adjustKey(String key) {
        if (key == null) {
            throw new IllegalArgumentException("Key cannot be null");
        }
        if (key.length() < 16) {
            return String.format("%-16s", key).substring(0, 16);
        } else if (key.length() > 16) {
            return key.substring(0, 16);
        }
        return key;
    }


}

