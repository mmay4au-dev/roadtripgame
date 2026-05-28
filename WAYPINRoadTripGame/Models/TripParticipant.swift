import Foundation

struct TripParticipant: Identifiable, Equatable {
    let id: UUID
    var displayName: String
    var role: PlayerRole
    var score: Int
    var isHost: Bool

    init(
        id: UUID = UUID(),
        displayName: String,
        role: PlayerRole,
        score: Int = 0,
        isHost: Bool = false
    ) {
        self.id = id
        self.displayName = displayName
        self.role = role
        self.score = score
        self.isHost = isHost
    }
}
