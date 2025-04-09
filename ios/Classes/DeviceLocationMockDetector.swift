import Foundation
import CoreLocation
import Flutter


public class DeviceLocationMockDetector : MssPluginBindinginterface {
    
    func performActivity(arguments: MssArguments, result: @escaping FlutterResult) {
        result(isLocationMocked())
    }
    
    private func isLocationMocked() -> Bool {
        let locationManager = CLLocationManager()
                
        if #available(iOS 15.0, *) {
            let isLocationSimulated =
            locationManager.location?.sourceInformation?.isSimulatedBySoftware ?? false
            let isProducedByAccessory =
            locationManager.location?.sourceInformation?.isProducedByAccessory ?? false
            
            return isLocationSimulated || isProducedByAccessory
        } else {
            return false
        }
    }
}
