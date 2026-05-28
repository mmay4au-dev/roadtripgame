import SwiftUI

struct TravelStyle: Identifiable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String
    let iconName: String
    let accentColor: Color
    let secondaryColor: Color
    let isRecommended: Bool

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        iconName: String,
        accentColor: Color,
        secondaryColor: Color,
        isRecommended: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.iconName = iconName
        self.accentColor = accentColor
        self.secondaryColor = secondaryColor
        self.isRecommended = isRecommended
    }

    static func == (lhs: TravelStyle, rhs: TravelStyle) -> Bool {
        lhs.id == rhs.id
    }
}
