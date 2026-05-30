import Foundation

enum ChallengeCategory: String, CaseIterable, Identifiable {
    case stateHunter
    case vehicleHunter
    case roadsideHunter
    case foodHunter

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .stateHunter:
            return "State Hunter"
        case .vehicleHunter:
            return "Vehicle Hunter"
        case .roadsideHunter:
            return "Roadside Hunter"
        case .foodHunter:
            return "Food Hunter"
        }
    }

    var iconName: String {
        switch self {
        case .stateHunter:
            return "map.fill"
        case .vehicleHunter:
            return "car.2.fill"
        case .roadsideHunter:
            return "signpost.right.fill"
        case .foodHunter:
            return "fork.knife"
        }
    }
}

enum Rarity: String, CaseIterable, Identifiable {
    case common
    case uncommon
    case rare
    case legendary

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .common:
            return "Common"
        case .uncommon:
            return "Uncommon"
        case .rare:
            return "Rare"
        case .legendary:
            return "Legendary"
        }
    }
}

struct ClaimableItem: Identifiable, Equatable {
    let id: UUID
    var title: String
    var category: ChallengeCategory
    var pointValue: Int
    var rarity: Rarity
    var isClaimed: Bool
    var claimedByPlayerName: String?
    var claimedAt: Date?

    init(
        id: UUID = UUID(),
        title: String,
        category: ChallengeCategory,
        pointValue: Int,
        rarity: Rarity,
        isClaimed: Bool = false,
        claimedByPlayerName: String? = nil,
        claimedAt: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.pointValue = pointValue
        self.rarity = rarity
        self.isClaimed = isClaimed
        self.claimedByPlayerName = claimedByPlayerName
        self.claimedAt = claimedAt
    }
}

struct ChallengeBoard: Identifiable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var category: ChallengeCategory
    var items: [ClaimableItem]

    var totalAvailablePoints: Int {
        items.reduce(0) { $0 + $1.pointValue }
    }

    var completedCount: Int {
        items.filter(\.isClaimed).count
    }

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        category: ChallengeCategory,
        items: [ClaimableItem]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.items = items
    }
}

struct ClaimEvent: Identifiable, Equatable {
    let id: UUID
    var message: String
    var playerName: String
    var itemTitle: String
    var points: Int
    var createdAt: Date

    init(
        id: UUID = UUID(),
        message: String,
        playerName: String,
        itemTitle: String,
        points: Int,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.message = message
        self.playerName = playerName
        self.itemTitle = itemTitle
        self.points = points
        self.createdAt = createdAt
    }
}
