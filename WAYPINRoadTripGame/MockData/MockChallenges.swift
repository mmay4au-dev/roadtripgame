import Foundation

enum MockChallenges {
    static let all: [RoadTripChallenge] = [
        RoadTripChallenge(
            title: "Sign Spotter",
            prompt: "Find a road sign for a place nobody in the car has visited.",
            category: .observation,
            difficulty: .easy,
            points: 10
        ),
        RoadTripChallenge(
            title: "Local Legend",
            prompt: "Make up a family-friendly legend about the next town name you see.",
            category: .storytelling,
            difficulty: .medium,
            points: 15
        ),
        RoadTripChallenge(
            title: "Color Count",
            prompt: "As passengers, count five vehicles with the same color before the song changes.",
            category: .teamwork,
            difficulty: .easy,
            points: 10
        ),
        RoadTripChallenge(
            title: "Scenic Snapshot",
            prompt: "When safely parked or as a passenger, capture a photo that represents this stretch of the trip.",
            category: .photo,
            difficulty: .medium,
            points: 20
        ),
        RoadTripChallenge(
            title: "Exit Trivia",
            prompt: "Guess what food, landmark, or business will appear first after the next exit sign.",
            category: .trivia,
            difficulty: .easy,
            points: 10
        )
    ]
}
