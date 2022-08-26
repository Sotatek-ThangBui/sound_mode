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
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            if #available(iOS 9.0, *) {
                AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), {

                });
                }
            Mute.shared.notify = {
               [weak self] m in
               self?.str = m ? "vibrate" : "normal"
            }
            result("hihi");
            break;
        case "setVibrateMode":
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate));
            result(nil);
            break;
        case "setNormalMode":
            AudioServicesPlaySystemSound(none);
            result(nil);
            break;
        default:
          break;
      }
  }
}
