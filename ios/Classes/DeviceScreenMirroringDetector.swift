import Foundation
import Flutter

public class DeviceScreenMirroringDetector : MssPluginBindinginterface {
    
    func performActivity(arguments: MssArguments, result: @escaping FlutterResult) {
        result(isScreenMirroringActive() || isScreenMirroringActiveFallBack())
    }
    
    private func isScreenMirroringActive() -> Bool {
        let mirrored = UIScreen.main.mirrored
        return mirrored != nil
    }
    
    private func isScreenMirroringActiveFallBack() -> Bool {
        let screens = UIScreen.screens
        return screens.count > 1
    }
    
}
