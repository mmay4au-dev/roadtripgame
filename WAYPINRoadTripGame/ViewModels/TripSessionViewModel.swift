import Foundation
import Combine

final class TripSessionViewModel: ObservableObject {
    @Published private(set) var session: TripSession?
    @Published private(set) var challenges: [RoadTripChallenge]
    @Published private(set) var completedChallengeIDs: Set<UUID> = []
    @Published private(set) var selectedTravelStyle: TravelStyle?
    @Published var selectedRole: PlayerRole = .navigator
    @Published var playerName: String = ""
    @Published var joinCode: String = ""

    private let challengeEngine: MockChallengeEngine

    init(challengeEngine: MockChallengeEngine = MockChallengeEngine()) {
        self.challengeEngine = challengeEngine
        self.challenges = challengeEngine.startingChallenges()
    }

    var currentParticipant: TripParticipant? {
        session?.participants.first
    }

    var currentScore: Int {
        currentParticipant?.score ?? 0
    }

    func createTrip(named name: String = "WAYPIN Road Trip") {
        let host = TripParticipant(
            displayName: playerName.isEmpty ? "Host" : playerName,
            role: selectedRole,
            isHost: true
        )

        session = TripSession(
            code: Self.generateMockTripCode(),
            name: name,
            participants: [host],
            activeChallengeIDs: challenges.map(\.id)
        )
    }

    func selectTravelStyle(_ travelStyle: TravelStyle) {
        selectedTravelStyle = travelStyle
    }

    func beginAdventure(with travelStyle: TravelStyle) {
        selectTravelStyle(travelStyle)
        selectedRole = .navigator
        playerName = "Road Crew"
        createTrip(named: "\(travelStyle.title) Trip")
    }

    func completeChallenge(_ challenge: RoadTripChallenge) {
        guard completedChallengeIDs.insert(challenge.id).inserted else {
            return
        }

        guard session?.participants.isEmpty == false else {
            return
        }

        session?.participants[0].score += challenge.points
    }

    func isChallengeCompleted(_ challenge: RoadTripChallenge) -> Bool {
        completedChallengeIDs.contains(challenge.id)
    }

    func joinTrip() {
        let participant = TripParticipant(
            displayName: playerName.isEmpty ? "Passenger" : playerName,
            role: selectedRole
        )

        if session == nil {
            session = TripSession(
                code: joinCode.isEmpty ? Self.generateMockTripCode() : joinCode.uppercased(),
                name: "Joined Road Trip",
                participants: [participant],
                activeChallengeIDs: challenges.map(\.id)
            )
        } else {
            session?.participants.append(participant)
        }
    }

    private static func generateMockTripCode() -> String {
        "WYPIN"
    }
}
