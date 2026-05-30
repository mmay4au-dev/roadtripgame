import SwiftUI

struct RoleSelectionCard: View {
    let roleOption: RoleOption
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: roleOption.iconName)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 58, height: 58)
                .background(
                    Circle()
                        .fill(roleOption.accentColor.opacity(0.24))
                        .shadow(color: roleOption.accentColor.opacity(0.68), radius: isSelected ? 28 : 14)
                )

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    Text(roleOption.title)
                        .font(.title2.weight(.black))
                        .foregroundStyle(.white)

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3.weight(.bold))
                            .foregroundStyle(.white)
                            .transition(.scale.combined(with: .opacity))
                    }
                }

                Text(roleOption.description)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.74))
                    .fixedSize(horizontal: false, vertical: true)

                Text(roleOption.challengeFocus)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.72))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.1), in: Capsule())
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(.ultraThinMaterial)
                .background(
                    LinearGradient(
                        colors: [
                            roleOption.accentColor.opacity(isSelected ? 0.34 : 0.18),
                            roleOption.secondaryColor.opacity(isSelected ? 0.2 : 0.08),
                            .black.opacity(0.4)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(isSelected ? roleOption.accentColor.opacity(0.95) : .white.opacity(0.14), lineWidth: isSelected ? 2 : 1)
                )
        )
        .shadow(color: isSelected ? roleOption.accentColor.opacity(0.42) : .black.opacity(0.28), radius: isSelected ? 28 : 16, x: 0, y: 12)
        .scaleEffect(isSelected ? 1.018 : 1)
        .animation(.spring(response: 0.42, dampingFraction: 0.82), value: isSelected)
    }
}

struct RoleSelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionCard(roleOption: MockRoleOptions.all[0], isSelected: true)
            .padding()
            .background(Color.black)
            .preferredColorScheme(.dark)
    }
}
