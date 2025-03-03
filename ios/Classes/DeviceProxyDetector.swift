import Foundation
import Flutter

public class DeviceProxyDetector : MssPluginBindinginterface {
    
    func performActivity(arguments: MssArguments, result: @escaping FlutterResult) {
        result(isUsingSystemProxy() || isProxySetInEnv())
    }
    
    private func isUsingSystemProxy() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        
        let httpProxyIp = nsDict[kCFNetworkProxiesHTTPProxy as String]
        let httpProxyPort = nsDict[kCFNetworkProxiesHTTPPort as String]
        let httpProxyEnabled = nsDict[kCFNetworkProxiesHTTPEnable as String] as? Bool ?? false
        
        let pacUrl = nsDict[kCFNetworkProxiesProxyAutoConfigURLString as String]
        let pacEnabled = nsDict[kCFNetworkProxiesProxyAutoConfigEnable as String] as? Bool ?? false
        
        return httpProxyEnabled || httpProxyIp != nil || httpProxyPort != nil || pacEnabled || pacUrl != nil
        
    }
    
    private func isProxySetInEnv() -> Bool {
        let envKeys = ["HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY"]
        
        for key in envKeys {
            let proxy = ProcessInfo.processInfo.environment[key]
            if(proxy != nil && !proxy!.isEmpty) { return true }
        }
        
        return false
    }
}
