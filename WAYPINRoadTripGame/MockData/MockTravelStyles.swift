import SwiftUI

enum MockTravelStyles {
    static let all: [TravelStyle] = [
        TravelStyle(
            title: "Scenic Explorer",
            subtitle: "Slow down. Chase sunsets. Take the long way home.",
            iconName: "sunset.fill",
            accentColor: .orange,
            secondaryColor: .pink,
            isRecommended: true
        ),
        TravelStyle(
            title: "Interstate Warrior",
            subtitle: "Fast roads, truck stops, chaos, and highway legends.",
            iconName: "road.lanes",
            accentColor: .cyan,
            secondaryColor: .blue
        ),
        TravelStyle(
            title: "Hidden Gem Hunter",
            subtitle: "Find the places nobody else notices.",
            iconName: "sparkle.magnifyingglass",
            accentColor: .green,
            secondaryColor: .mint,
            isRecommended: true
        ),
        TravelStyle(
            title: "Foodie Run",
            subtitle: "Road trip America one meal at a time.",
            iconName: "fork.knife",
            accentColor: .yellow,
            secondaryColor: .orange
        ),
        TravelStyle(
            title: "Americana Mode",
            subtitle: "Vintage motels, neon signs, diners, and Route 66 vibes.",
            iconName: "signpost.right.and.left.fill",
            accentColor: .red,
            secondaryColor: .purple,
            isRecommended: true
        ),
        TravelStyle(
            title: "Crew Chaos",
            subtitle: "Competitive road trip madness for the whole car.",
            iconName: "person.3.sequence.fill",
            accentColor: .purple,
            secondaryColor: .cyan
        )
    ]
}
