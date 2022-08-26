import Flutter
import UIKit
import Mute
import AudioToolbox.AudioServices

public class SwiftSoundModePlugin: NSObject, FlutterPlugin {
  var str: String = "unknown" 

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "method.channel.audio", binaryMessenger: registrar.messenger())
    let instance = SwiftSoundModePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
        case "getRingerMode":

             Mute.shared.notify = { 
               [weak self] m in
               self?.str = m ? "vibrate" : "normal"
              }

          result(self.str);
        case "setVibrateMode":
            AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), {});
        default:
          break;
      }
  }
}
