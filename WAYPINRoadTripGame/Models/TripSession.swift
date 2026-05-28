import Foundation

struct TripSession: Identifiable, Equatable {
    let id: UUID
    var code: String
    var name: String
    var participants: [TripParticipant]
    var activeChallengeIDs: [UUID]
    var startedAt: Date

    init(
        id: UUID = UUID(),
        code: String,
        name: String,
        participants: [TripParticipant] = [],
        activeChallengeIDs: [UUID] = [],
        startedAt: Date = Date()
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.participants = participants
        self.activeChallengeIDs = activeChallengeIDs
        self.startedAt = startedAt
    }
}
