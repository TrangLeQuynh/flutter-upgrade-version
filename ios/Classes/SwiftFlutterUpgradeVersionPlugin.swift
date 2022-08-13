import Flutter
import UIKit

public class SwiftFlutterUpgradeVersionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    _ = PackageInfoHandler(with: registrar)
  }
}
