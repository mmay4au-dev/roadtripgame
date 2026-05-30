import Foundation

enum PlayerRole: String, CaseIterable, Identifiable {
    case navigator
    case spotter
    case foodHunter
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
        case .foodHunter:
            return "Food Hunter"
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

    var description: String {
        switch self {
        case .navigator:
            return "Keeps an eye on stops, timing, and what is coming up."
        case .spotter:
            return "Finds signs, landmarks, vehicles, and roadside details."
        case .foodHunter:
            return "Tracks snacks, diners, local favorites, and roadside food stops."
        case .historian:
            return "Adds stories, trivia guesses, and trip context."
        case .photographer:
            return "Captures safe passenger photos and future timeline moments."
        case .dj:
            return "Handles music prompts and car energy."
        case .driver:
            return "Audio-first placeholder. No interactive gameplay while driving."
        }
    }

    var iconName: String {
        switch self {
        case .navigator:
            return "location.fill"
        case .spotter:
            return "binoculars.fill"
        case .foodHunter:
            return "fork.knife"
        case .historian:
            return "book.closed.fill"
        case .photographer:
            return "camera.fill"
        case .dj:
            return "music.note.list"
        case .driver:
            return "steeringwheel"
        }
    }
}
