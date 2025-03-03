import Foundation
import Flutter

public class DeviceVpnDetector : MssPluginBindinginterface {
    func performActivity(arguments: MssArguments, result: @escaping FlutterResult) {
        result(isVpnActive())
    }
    
    private func isVpnActive() -> Bool {
        let vpnProtocolKeyIdentifiers = ["tap", "tun", "ppp", "ipsec", "utun", "pptp"]
        
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
              let allKeys = keys.allKeys as? [String] else { return false }
        
        for key in allKeys {
            for protocolId in vpnProtocolKeyIdentifiers
            where key.starts(with: protocolId) { return true }
        }
        
        return false
        
    }
    
}
