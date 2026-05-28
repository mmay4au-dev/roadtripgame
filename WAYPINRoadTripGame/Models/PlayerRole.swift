import Foundation

enum PlayerRole: String, CaseIterable, Identifiable {
    case navigator
    case spotter
    case historian
    case photographer
    case dj
    case driver

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .navigator:
            return "Navigator"
        case .spotter:
            return "Spotter"
        case .historian:
            return "Historian"
        case .photographer:
            return "Photographer"
        case .dj:
            return "DJ"
        case .driver:
            return "Driver"
        }
    }

    var isPassengerFirst: Bool {
        self != .driver
    }
}
