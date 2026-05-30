import SwiftUI

struct RoleOption: Identifiable, Equatable {
    let id: UUID
    let playerRole: PlayerRole
    let title: String
    let iconName: String
    let description: String
    let accentColor: Color
    let secondaryColor: Color
    let challengeFocus: String

    init(
        id: UUID = UUID(),
        playerRole: PlayerRole,
        title: String,
        iconName: String,
        description: String,
        accentColor: Color,
        secondaryColor: Color,
        challengeFocus: String
    ) {
        self.id = id
        self.playerRole = playerRole
        self.title = title
        self.iconName = iconName
        self.description = description
        self.accentColor = accentColor
        self.secondaryColor = secondaryColor
        self.challengeFocus = challengeFocus
    }

    static func == (lhs: RoleOption, rhs: RoleOption) -> Bool {
        lhs.id == rhs.id
    }
}
