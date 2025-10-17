import SwiftUI

struct InterfaceOrientationHelper {
    static var current: UIInterfaceOrientation? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.interfaceOrientation
    }

    static var isLandscape: Bool {
        guard let orientation = current else { return false }
        return orientation.isLandscape
    }

    static var isPortrait: Bool {
        guard let orientation = current else { return false }
        return orientation.isPortrait
    }
}
