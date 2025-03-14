package com.aloysjehwin.taxiApp;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class Solutions {

    // Method to encrypt a message using AES encryption
    public static String encrypt(String message, String key) throws Exception {
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedBytes = cipher.doFinal(message.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    // Method to decrypt a message using AES decryption
    public static String decrypt(String encryptedMessage, String key) throws Exception {
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedMessage));
        return new String(decryptedBytes);
    }

    // Main method for testing encryption and decryption
    public static void main(String[] args) {
        try {
            String message = "Hello, Secure World!";
            String secretKey = "1234567890123456"; // 16 bytes key (AES-128)

            System.out.println("Original Message: " + message);

            // Encrypt the message
            String encryptedMessage = encrypt(message, secretKey);
            System.out.println("Encrypted Message: " + encryptedMessage);

            // Decrypt the message
            String decryptedMessage = decrypt(encryptedMessage, secretKey);
            System.out.println("Decrypted Message: " + decryptedMessage);

            // Verify if the decrypted message matches the original message
            if (message.equals(decryptedMessage)) {
                System.out.println("Decryption successful!");
            } else {
                System.out.println("Decryption failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
