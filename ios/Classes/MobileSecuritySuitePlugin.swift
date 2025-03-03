import Flutter

public class MobileSecuritySuitePlugin: NSObject, FlutterPlugin {
    var deviceVpnDetector: DeviceVpnDetector?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mobile_security_suite", binaryMessenger: registrar.messenger())
        let instance = MobileSecuritySuitePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
}

protocol MssPluginBindinginterface {
    func performActivity(arguments: MssArguments, result: @escaping FlutterResult)
}

public class MssArguments {
    let arguments: [String: Any]
    init(arguments: [String : Any]) { self.arguments = arguments }
}

public class MethodNames {
    static let VPN = "vpn"
    static let PROXY = "proxy"
    static let WIFI_SECURITY = "wifiSecurity"
    static let SCREEN_MIRRORING = "screenMirroring"
    static let LOCATION_MOCK = "locationMock"
    static let TAP_JACKING = "tapJacking"
    static let SCREEN_OBFUSCATE = "screenObfuscate"
}
