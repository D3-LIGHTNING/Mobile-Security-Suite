import Flutter

public class MobileSecuritySuitePlugin: NSObject, FlutterPlugin {
    var deviceVpnDetector: DeviceVpnDetector?
    var deviceProxyDetector: DeviceProxyDetector?
    var deviceScreenMirroringDetector: DeviceScreenMirroringDetector?
    var deviceLocationMockDetector: DeviceLocationMockDetector?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mobile_security_suite", binaryMessenger: registrar.messenger())
        let instance = MobileSecuritySuitePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public override init() {
        self.deviceVpnDetector = DeviceVpnDetector()
        self.deviceProxyDetector = DeviceProxyDetector()
        self.deviceScreenMirroringDetector = DeviceScreenMirroringDetector()
        self.deviceLocationMockDetector = DeviceLocationMockDetector()
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let arguments: [String: Any]? = call.arguments as? [String: Any]
        
        switch(call.method) {
            
        case MethodNames.VPN:
            return self.deviceVpnDetector!.performActivity(arguments: MssArguments(arguments: arguments), result: result)
            
            
        case MethodNames.PROXY:
            return self.deviceProxyDetector!.performActivity(arguments: MssArguments(arguments: arguments), result: result)
            
        case MethodNames.WIFI_SECURITY:
            return result(true)
            
        case MethodNames.SCREEN_MIRRORING:
            return self.deviceScreenMirroringDetector!.performActivity(arguments: MssArguments(arguments: arguments), result: result)
            
        case MethodNames.LOCATION_MOCK:
            return self.deviceLocationMockDetector!.performActivity(arguments: MssArguments(arguments: arguments), result: result)
            
        case MethodNames.TAP_JACKING:
            return result(true)
            
        case MethodNames.SCREEN_OBFUSCATE:
            return result(true)
            
        default:
           return result(FlutterMethodNotImplemented)
        }
    }
}

protocol MssPluginBindinginterface {
    func performActivity(arguments: MssArguments, result: @escaping FlutterResult)
}

public class MssArguments {
    let arguments: [String: Any]?
    init(arguments: [String : Any]?) { self.arguments = arguments }
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
