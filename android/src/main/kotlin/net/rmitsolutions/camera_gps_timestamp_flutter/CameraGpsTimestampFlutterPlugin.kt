package net.rmitsolutions.camera_gps_timestamp_flutter


import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import net.rmitsolutions.camera_gps_timestamp.CameraActivity
import net.rmitsolutions.camera_gps_timestamp.CameraGpsConstants
import net.rmitsolutions.camera_gps_timestamp.LocationModel
import java.io.ByteArrayOutputStream
import java.io.File

/** CameraGpsTimestampFlutterPlugin */
class CameraGpsTimestampFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    private val photoRequestCode = 199
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel
    private lateinit var result: Result

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "camera_gps_timestamp_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result
        if (call.method == "takePhoto") {
            val intent = Intent(activity?.applicationContext, CameraActivity::class.java)
            activity?.startActivityForResult(intent, photoRequestCode)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null;
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == photoRequestCode && resultCode == Activity.RESULT_OK) {
            val uri: Uri? = if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.S_V2) {
                data!!.extras!!.getParcelable<Uri>(CameraGpsConstants.filePathExtra)
            } else {
                data!!.extras!!.getParcelable(CameraGpsConstants.filePathExtra, Uri::class.java)
            }

            val location: LocationModel? = if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.S_V2) {
                data.extras!!.getParcelable<LocationModel>(CameraGpsConstants.locationExtra)
            } else {
                data.extras!!.getParcelable(CameraGpsConstants.locationExtra, LocationModel::class.java)
            }

            if (uri == null) {
                result.error("", "No photo taken.", "")
                return true
            }

            val list = listOf(uri.path!!, "${location!!.latitude},${location.longitude}")
            result.success(list)

            /*File(uri.path!!).inputStream().use {
                val imageBytes = it.readBytes()
                result.success(imageBytes)
            }*/

            return true
        }
        return false
    }
}
