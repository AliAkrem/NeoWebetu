package io.aliakrem.neowebetu

import android.app.*
import android.content.Intent
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import androidx.core.app.NotificationCompat
import io.flutter.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class ForegroundService : Service() {
    private val CHANNEL_ID = "ForegroundServiceChannel"
    private val NOTIFICATION_ID = 1
    private lateinit var flutterEngine: FlutterEngine
    private lateinit var methodChannel: MethodChannel
    private val handler = Handler(Looper.getMainLooper())
    private val revalidateInterval = 1 * 60 * 1000L // 1 minutes

    override fun onCreate() {
        super.onCreate()
        Log.d("ForegroundService", "Service onCreate called")
        createNotificationChannel()
        setupFlutterEngine()
    }

    private fun createNotificationChannel() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            val serviceChannel =
                    NotificationChannel(
                            CHANNEL_ID,
                            "Foreground Service Channel",
                            NotificationManager.IMPORTANCE_LOW
                    )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
        }
    }

    private fun setupFlutterEngine() {
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        )
        methodChannel =
                MethodChannel(
                        flutterEngine.dartExecutor.binaryMessenger,
                        "io.aliakrem/background_channel"
                )
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("ForegroundService", "Service onStartCommand called")
        val notification =
                NotificationCompat.Builder(this, CHANNEL_ID)
                        .setContentTitle("Background Service")
                        .setContentText("Service is running")
                        .setSmallIcon(R.mipmap.ic_launcher)
                        .build()

        startForeground(NOTIFICATION_ID, notification)

        startPeriodicRevalidation()

        return START_STICKY
    }

    private fun startPeriodicRevalidation() {
        handler.postDelayed(
                object : Runnable {
                    override fun run() {
                        methodChannel.invokeMethod("revalidate", null)
                        handler.postDelayed(this, revalidateInterval)
                    }
                },
                revalidateInterval
        )
    }

    override fun onBind(intent: Intent): IBinder? = null

    override fun onDestroy() {
        handler.removeCallbacksAndMessages(null)
        flutterEngine.destroy()
        super.onDestroy()
    }
}
