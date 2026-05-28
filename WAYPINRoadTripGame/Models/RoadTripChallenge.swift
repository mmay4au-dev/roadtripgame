import Foundation

struct RoadTripChallenge: Identifiable, Equatable {
    enum Category: String, CaseIterable {
        case observation
        case trivia
        case teamwork
        case photo
        case storytelling
    }

    enum Difficulty: String, CaseIterable {
        case easy
        case medium
        case hard
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
