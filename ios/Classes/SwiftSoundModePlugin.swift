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
      print("==========, \(call.method)");
      switch call.method {
        case "getRingerMode":
            Mute.shared.notify = {
               [weak self] m in
               self?.str = m ? "vibrate" : "normal"
            }
            result(self.str);
            break;
        case "setVibrateMode":
            print("setVibrateMode");
//             AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate));
            result("haiz");
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
