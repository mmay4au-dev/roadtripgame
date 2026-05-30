import Foundation
import Combine

final class TripSessionViewModel: ObservableObject {
    @Published private(set) var session: TripSession?
    @Published private(set) var challenges: [RoadTripChallenge]
    @Published private(set) var challengeBoards: [ChallengeBoard]
    @Published private(set) var activeChallengeBoardID: UUID?
    @Published private(set) var claimEvents: [ClaimEvent] = []
    @Published private(set) var completedChallengeIDs: Set<UUID> = []
    @Published private(set) var localScore: Int = 0
    @Published private(set) var selectedTravelStyle: TravelStyle?
    @Published private(set) var selectedRoleOption: RoleOption?
    @Published var selectedRole: PlayerRole = .navigator
    @Published var playerName: String = ""
    @Published var joinCode: String = ""

    private let challengeEngine: MockChallengeEngine

    init(challengeEngine: MockChallengeEngine = MockChallengeEngine()) {
        self.challengeEngine = challengeEngine
        self.challenges = challengeEngine.startingChallenges()
        self.challengeBoards = MockChallengeBoards.all
        self.activeChallengeBoardID = MockChallengeBoards.all.first?.id
    }

    var currentParticipant: TripParticipant? {
        session?.participants.first
    }

    var currentScore: Int {
        currentParticipant?.score ?? localScore
    }

    var activeChallengeBoard: ChallengeBoard? {
        guard let activeChallengeBoardID else {
            return challengeBoards.first
        }

        return challengeBoards.first { $0.id == activeChallengeBoardID } ?? challengeBoards.first
    }

    var completedClaimCount: Int {
        challengeBoards.reduce(0) { total, board in
            total + board.completedCount
        }
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

    func selectRole(_ roleOption: RoleOption) {
        selectedRoleOption = roleOption
        selectedRole = roleOption.playerRole
    }

    func beginAdventure(
        with roleOption: RoleOption,
        tripName: String,
        playerName: String
    ) {
        selectRole(roleOption)
        self.playerName = playerName
        createTrip(named: tripName)
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

    func selectChallengeBoard(_ board: ChallengeBoard) {
        activeChallengeBoardID = board.id
    }

    func claimItem(_ item: ClaimableItem, on board: ChallengeBoard) {
        guard let boardIndex = challengeBoards.firstIndex(where: { $0.id == board.id }),
              let itemIndex = challengeBoards[boardIndex].items.firstIndex(where: { $0.id == item.id }),
              challengeBoards[boardIndex].items[itemIndex].isClaimed == false
        else {
            return
        }

        let player = currentParticipant?.displayName ?? (playerName.isEmpty ? "Marcus" : playerName)
        let claimedAt = Date()
        challengeBoards[boardIndex].items[itemIndex].isClaimed = true
        challengeBoards[boardIndex].items[itemIndex].claimedByPlayerName = player
        challengeBoards[boardIndex].items[itemIndex].claimedAt = claimedAt

        if session?.participants.isEmpty == false {
            session?.participants[0].score += item.pointValue
        } else {
            localScore += item.pointValue
        }

        let message = "\(player) claimed \(item.title) for \(item.pointValue) points."
        claimEvents.insert(
            ClaimEvent(
                message: message,
                playerName: player,
                itemTitle: item.title,
                points: item.pointValue,
                createdAt: claimedAt
            ),
            at: 0
        )
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
