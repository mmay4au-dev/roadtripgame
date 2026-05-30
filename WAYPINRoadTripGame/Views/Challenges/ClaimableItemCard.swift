import SwiftUI

struct ClaimableItemCard: View {
    let item: ClaimableItem
    let accentColor: Color
    let onClaim: () -> Void

    @State private var isPressed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.headline.weight(.heavy))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.82)

                    HStack(spacing: 8) {
                        Label("\(item.pointValue)", systemImage: "bolt.fill")
                        Text(item.rarity.displayName)
                    }
                    .font(.caption.weight(.bold))
                    .foregroundStyle(item.rarity.accentColor)
                }

                Spacer(minLength: 8)

                Image(systemName: item.isClaimed ? "lock.fill" : "scope")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(item.isClaimed ? .white.opacity(0.52) : accentColor)
            }

            if let claimedByPlayerName = item.claimedByPlayerName {
                Text("Claimed by \(claimedByPlayerName)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.64))
            } else {
                Text("First claim wins")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.48))
            }

            Button {
                onClaim()
            } label: {
                Text(item.isClaimed ? "Claimed" : "Claim")
                    .font(.subheadline.weight(.heavy))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 11)
            }
            .buttonStyle(.plain)
            .foregroundStyle(item.isClaimed ? .white.opacity(0.58) : .black)
            .background(
                item.isClaimed ? Color.white.opacity(0.08) : accentColor,
                in: RoundedRectangle(cornerRadius: 14, style: .continuous)
            )
            .disabled(item.isClaimed)
        }
        .padding(16)
        .background(cardBackground, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(item.isClaimed ? .white.opacity(0.09) : accentColor.opacity(0.28), lineWidth: 1)
        }
        .shadow(color: item.isClaimed ? .clear : accentColor.opacity(0.22), radius: 18, y: 10)
        .scaleEffect(isPressed ? 0.98 : 1)
        .animation(.spring(response: 0.28, dampingFraction: 0.82), value: isPressed)
        .onLongPressGesture(minimumDuration: 0.01, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }

    private var cardBackground: some ShapeStyle {
        LinearGradient(
            colors: [
                item.isClaimed ? Color.white.opacity(0.08) : accentColor.opacity(0.2),
                Color.black.opacity(0.34)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

extension Rarity {
    var accentColor: Color {
        switch self {
        case .common:
            return .white.opacity(0.7)
        case .uncommon:
            return .mint
        case .rare:
            return .cyan
        case .legendary:
            return .yellow
        }
    }
}
