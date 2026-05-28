import Foundation

struct RoadTripChallenge: Identifiable, Equatable {
    enum Category: String, CaseIterable {
        case observation
        case trivia
        case teamwork
        case photo
        case storytelling

        var displayName: String {
            switch self {
            case .observation:
                return "Observation"
            case .trivia:
                return "Trivia"
            case .teamwork:
                return "Teamwork"
            case .photo:
                return "Photo"
            case .storytelling:
                return "Storytelling"
            }
        }
    }

    enum Difficulty: String, CaseIterable {
        case easy
        case medium
        case hard

        var displayName: String {
            switch self {
            case .easy:
                return "Easy"
            case .medium:
                return "Medium"
            case .hard:
                return "Hard"
            }
        }
    }

    let id: UUID
    var title: String
    var prompt: String
    var category: Category
    var difficulty: Difficulty
    var points: Int
    var passengerOnly: Bool

    init(
        id: UUID = UUID(),
        title: String,
        prompt: String,
        category: Category,
        difficulty: Difficulty = .easy,
        points: Int = 10,
        passengerOnly: Bool = true
    ) {
        self.id = id
        self.title = title
        self.prompt = prompt
        self.category = category
        self.difficulty = difficulty
        self.points = points
        self.passengerOnly = passengerOnly
    }
}
