import Foundation

struct MockChallengeEngine {
    func startingChallenges() -> [RoadTripChallenge] {
        MockChallenges.all
    }
}
