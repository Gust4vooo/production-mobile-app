package com.example.seger

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import java.io.File

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.seger/qr_saver"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "saveImageToGallery" -> {
                        val imagePath = call.argument<String>("imagePath")
                        val albumName = call.argument<String>("albumName")
                        val fileName = call.argument<String>("fileName")
                        
                        try {
                            if (imagePath != null && albumName != null && fileName != null) {
                                val success = saveImageToGallery(imagePath, albumName, fileName)
                                result.success(success)
                            } else {
                                result.error("INVALID_ARGS", "Missing required arguments", null)
                            }
                        } catch (e: Exception) {
                            result.error("ERROR", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun saveImageToGallery(imagePath: String, albumName: String, fileName: String): Boolean {
        return try {
            val sourceFile = File(imagePath)
            if (!sourceFile.exists()) return false

            val contentValues = ContentValues().apply {
                put(MediaStore.Images.Media.DISPLAY_NAME, fileName)
                put(MediaStore.Images.Media.MIME_TYPE, "image/png")
                put(MediaStore.Images.Media.RELATIVE_PATH, "Pictures/$albumName")
            }

            val uri = contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues)
            if (uri != null) {
                contentResolver.openOutputStream(uri)?.use { outputStream ->
                    sourceFile.inputStream().use { inputStream ->
                        inputStream.copyTo(outputStream)
                    }
                }
                true
            } else {
                false
            }
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }
}
