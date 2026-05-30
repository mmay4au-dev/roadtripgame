import Foundation

enum MockChallengeBoards {
    static let all: [ChallengeBoard] = [
        ChallengeBoard(
            title: "State Hunter",
            description: "Claim rare license plates and faraway tags before the rest of the crew spots them.",
            category: .stateHunter,
            items: [
                ClaimableItem(title: "Alaska", category: .stateHunter, pointValue: 50, rarity: .rare),
                ClaimableItem(title: "Hawaii", category: .stateHunter, pointValue: 50, rarity: .rare),
                ClaimableItem(title: "Maine", category: .stateHunter, pointValue: 25, rarity: .uncommon),
                ClaimableItem(title: "Oregon", category: .stateHunter, pointValue: 25, rarity: .uncommon),
                ClaimableItem(title: "Vermont", category: .stateHunter, pointValue: 25, rarity: .uncommon),
                ClaimableItem(title: "Washington DC", category: .stateHunter, pointValue: 35, rarity: .rare),
                ClaimableItem(title: "Montana", category: .stateHunter, pointValue: 20, rarity: .uncommon)
            ]
        ),
        ChallengeBoard(
            title: "Vehicle Hunter",
            description: "Turn the highway into a rolling garage of hard-to-find rides.",
            category: .vehicleHunter,
            items: [
                ClaimableItem(title: "Jeep Wrangler", category: .vehicleHunter, pointValue: 10, rarity: .common),
                ClaimableItem(title: "Motorcycle", category: .vehicleHunter, pointValue: 10, rarity: .common),
                ClaimableItem(title: "RV", category: .vehicleHunter, pointValue: 15, rarity: .common),
                ClaimableItem(title: "Corvette", category: .vehicleHunter, pointValue: 25, rarity: .uncommon),
                ClaimableItem(title: "Tesla Cybertruck", category: .vehicleHunter, pointValue: 40, rarity: .rare),
                ClaimableItem(title: "Classic Car", category: .vehicleHunter, pointValue: 30, rarity: .uncommon)
            ]
        ),
        ChallengeBoard(
            title: "Roadside Hunter",
            description: "Score the strange, scenic, and iconic things that make the road memorable.",
            category: .roadsideHunter,
            items: [
                ClaimableItem(title: "Water Tower", category: .roadsideHunter, pointValue: 10, rarity: .common),
                ClaimableItem(title: "Historic Marker", category: .roadsideHunter, pointValue: 20, rarity: .uncommon),
                ClaimableItem(title: "Giant Flag", category: .roadsideHunter, pointValue: 20, rarity: .uncommon),
                ClaimableItem(title: "Covered Bridge", category: .roadsideHunter, pointValue: 40, rarity: .rare),
                ClaimableItem(title: "Lighthouse", category: .roadsideHunter, pointValue: 50, rarity: .legendary),
                ClaimableItem(title: "Neon Motel Sign", category: .roadsideHunter, pointValue: 35, rarity: .rare)
            ]
        ),
        ChallengeBoard(
            title: "Food Hunter",
            description: "Collect the local bites, counters, carts, and roadside flavor stops along the route.",
            category: .foodHunter,
            items: [
                ClaimableItem(title: "Local BBQ Joint", category: .foodHunter, pointValue: 20, rarity: .uncommon),
                ClaimableItem(title: "Diner", category: .foodHunter, pointValue: 15, rarity: .common),
                ClaimableItem(title: "Food Truck", category: .foodHunter, pointValue: 25, rarity: .uncommon),
                ClaimableItem(title: "Local Coffee Shop", category: .foodHunter, pointValue: 15, rarity: .common),
                ClaimableItem(title: "Bakery", category: .foodHunter, pointValue: 15, rarity: .common),
                ClaimableItem(title: "Roadside Produce Stand", category: .foodHunter, pointValue: 25, rarity: .uncommon)
            ]
        )
    ]
}
