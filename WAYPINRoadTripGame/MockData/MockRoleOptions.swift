import SwiftUI

enum MockRoleOptions {
    static let all: [RoleOption] = [
        RoleOption(
            playerRole: .spotter,
            title: "Spotter",
            iconName: "binoculars.fill",
            description: "Watch the world outside. Call out signs, landmarks, oddities, and blink-and-you-miss-it details.",
            accentColor: .cyan,
            secondaryColor: .blue,
            challengeFocus: "Observation and discovery prompts"
        ),
        RoleOption(
            playerRole: .navigator,
            title: "Navigator",
            iconName: "location.north.line.fill",
            description: "Read the road like a quest map. Keep the crew oriented and make the next stop feel intentional.",
            accentColor: .green,
            secondaryColor: .mint,
            challengeFocus: "Route awareness and timing prompts"
        ),
        RoleOption(
            playerRole: .foodHunter,
            title: "Food Hunter",
            iconName: "fork.knife",
            description: "Track the legendary bites. Diners, gas station snacks, local icons, and roadside cravings are your domain.",
            accentColor: .orange,
            secondaryColor: .yellow,
            challengeFocus: "Food, stop, and local flavor prompts"
        ),
        RoleOption(
            playerRole: .historian,
            title: "Historian",
            iconName: "building.columns.fill",
            description: "Turn places into stories. Find the old roads, strange names, local lore, and mythic trip moments.",
            accentColor: .purple,
            secondaryColor: .pink,
            challengeFocus: "Trivia, lore, and storytelling prompts"
        )
    ]
}
