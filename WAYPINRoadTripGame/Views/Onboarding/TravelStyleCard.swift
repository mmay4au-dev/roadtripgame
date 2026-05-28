import SwiftUI

struct TravelStyleCard: View {
    let travelStyle: TravelStyle
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            background

            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .top) {
                    Image(systemName: travelStyle.iconName)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 62, height: 62)
                        .background(
                            Circle()
                                .fill(.white.opacity(0.14))
                                .shadow(color: travelStyle.accentColor.opacity(0.72), radius: 24)
                        )

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2.weight(.bold))
                            .foregroundStyle(.white)
                            .shadow(color: travelStyle.accentColor, radius: 12)
                            .transition(.scale.combined(with: .opacity))
                    }
                }

                Spacer(minLength: 18)

                VStack(alignment: .leading, spacing: 10) {
                    if travelStyle.isRecommended {
                        Text("Recommended for your route")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white.opacity(0.82))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.white.opacity(0.12), in: Capsule())
                    }

                    Text(travelStyle.title)
                        .font(.system(size: 30, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.76)

                    Text(travelStyle.subtitle)
                        .font(.body.weight(.medium))
                        .foregroundStyle(.white.opacity(0.78))
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(22)
        }
        .frame(maxWidth: .infinity, minHeight: 242)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(
                    isSelected ? travelStyle.accentColor.opacity(0.95) : .white.opacity(0.16),
                    lineWidth: isSelected ? 2 : 1
                )
        )
        .shadow(
            color: isSelected ? travelStyle.accentColor.opacity(0.48) : .black.opacity(0.34),
            radius: isSelected ? 34 : 18,
            x: 0,
            y: isSelected ? 18 : 10
        )
        .scaleEffect(isSelected ? 1.025 : 1)
        .animation(.spring(response: 0.45, dampingFraction: 0.82), value: isSelected)
    }

    private var background: some View {
        ZStack {
            LinearGradient(
                colors: [
                    travelStyle.accentColor.opacity(0.78),
                    travelStyle.secondaryColor.opacity(0.38),
                    Color.black.opacity(0.94)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [.white.opacity(0.22), .clear],
                center: .topTrailing,
                startRadius: 8,
                endRadius: 210
            )

            TravelStyleAtmosphere()
                .stroke(.white.opacity(0.16), lineWidth: 1)
                .blur(radius: 0.4)
        }
    }
}

private struct TravelStyleAtmosphere: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX - 24, y: rect.height * 0.72))
        path.addCurve(
            to: CGPoint(x: rect.width * 0.72, y: rect.height * 0.4),
            control1: CGPoint(x: rect.width * 0.24, y: rect.height * 0.88),
            control2: CGPoint(x: rect.width * 0.34, y: rect.height * 0.2)
        )
        path.addCurve(
            to: CGPoint(x: rect.maxX + 36, y: rect.height * 0.58),
            control1: CGPoint(x: rect.width * 0.88, y: rect.height * 0.52),
            control2: CGPoint(x: rect.width * 0.86, y: rect.height * 0.72)
        )
        return path
    }
}

struct TravelStyleCard_Previews: PreviewProvider {
    static var previews: some View {
        TravelStyleCard(
            travelStyle: MockTravelStyles.all[0],
            isSelected: true
        )
        .padding()
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
}
