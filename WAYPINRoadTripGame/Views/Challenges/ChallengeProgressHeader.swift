import SwiftUI

struct ChallengeProgressHeader: View {
    let board: ChallengeBoard
    let playerScore: Int

    private var progress: Double {
        guard board.items.isEmpty == false else {
            return 0
        }

        return Double(board.completedCount) / Double(board.items.count)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    Circle()
                        .fill(board.category.accentColor.opacity(0.2))
                    Image(systemName: board.category.iconName)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(board.category.accentColor)
                }
                .frame(width: 54, height: 54)

                VStack(alignment: .leading, spacing: 6) {
                    Text(board.title)
                        .font(.title2.weight(.heavy))
                        .foregroundStyle(.white)
                    Text(board.description)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.72))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
            }

            HStack(spacing: 10) {
                ChallengeMetricPill(title: "Score", value: "\(playerScore)")
                ChallengeMetricPill(title: "Claims", value: "\(board.completedCount)/\(board.items.count)")
                ChallengeMetricPill(title: "Board", value: "\(board.totalAvailablePoints) pts")
            }

            VStack(alignment: .leading, spacing: 8) {
                GeometryReader { proxy in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(.white.opacity(0.12))
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [board.category.accentColor, .yellow],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: proxy.size.width * progress)
                    }
                }
                .frame(height: 8)

                Text("Passenger play only. Drivers keep eyes on the road.")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.white.opacity(0.58))
            }
        }
        .padding(18)
        .background(.ultraThinMaterial.opacity(0.74), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.14), lineWidth: 1)
        }
    }
}

private struct ChallengeMetricPill: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title.uppercased())
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white.opacity(0.54))
            Text(value)
                .font(.callout.weight(.heavy))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.black.opacity(0.24), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

extension ChallengeCategory {
    var accentColor: Color {
        switch self {
        case .stateHunter:
            return .cyan
        case .vehicleHunter:
            return .orange
        case .roadsideHunter:
            return .mint
        case .foodHunter:
            return .pink
        }
    }
}
