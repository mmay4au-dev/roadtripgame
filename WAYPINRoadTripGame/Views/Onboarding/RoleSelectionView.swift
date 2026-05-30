import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel
    @State private var selectedRoleOption: RoleOption?
    @State private var showDashboard = false
    @State private var appeared = false

    let tripName: String
    let playerName: String

    private let roleOptions = MockRoleOptions.all

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    header
                        .padding(.horizontal, 24)
                        .padding(.top, 18)

                    LazyVStack(spacing: 16) {
                        ForEach(Array(roleOptions.enumerated()), id: \.element.id) { index, roleOption in
                            Button {
                                withAnimation(.spring(response: 0.46, dampingFraction: 0.82)) {
                                    selectedRoleOption = roleOption
                                }
                            } label: {
                                RoleSelectionCard(
                                    roleOption: roleOption,
                                    isSelected: selectedRoleOption?.id == roleOption.id
                                )
                            }
                            .buttonStyle(.plain)
                            .offset(y: appeared ? 0 : 26)
                            .opacity(appeared ? 1 : 0)
                            .animation(
                                .spring(response: 0.52, dampingFraction: 0.86)
                                    .delay(Double(index) * 0.06),
                                value: appeared
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 4)
                    .padding(.bottom, 180)
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                bottomCTAContainer
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .preferredColorScheme(.dark)
        .navigationDestination(isPresented: $showDashboard) {
            ActiveTripDashboardView(
                tripName: tripName,
                selectedTravelStyle: viewModel.selectedTravelStyle,
                selectedPlayerRole: selectedRoleOption?.playerRole ?? .navigator,
                playerName: playerName
            )
        }
        .onAppear {
            appeared = true
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Choose your role")
                .font(.system(size: 42, weight: .black, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.82)

            Text("Every crew member shapes the road. Pick how you want to play this trip.")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.68))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var continueButton: some View {
        Button {
            guard let selectedRoleOption else {
                return
            }

            print("Entering dashboard with role: \(selectedRoleOption.title)")
            viewModel.selectRole(selectedRoleOption)
            viewModel.playerName = playerName
            showDashboard = true
        } label: {
            HStack {
                Text("Enter Trip Dashboard")
                    .font(.headline.weight(.bold))

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.headline.weight(.black))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 22)
            .frame(height: 62)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(selectedRoleOption == nil ? .white.opacity(0.12) : .cyan.opacity(0.82))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(.white.opacity(selectedRoleOption == nil ? 0.1 : 0.28), lineWidth: 1)
                    )
                    .shadow(color: .cyan.opacity(selectedRoleOption == nil ? 0 : 0.45), radius: 28, x: 0, y: 12)
            )
        }
        .disabled(selectedRoleOption == nil)
        .buttonStyle(RoleContinueButtonStyle())
    }

    private var bottomCTAContainer: some View {
        continueButton
            .padding(.horizontal, 22)
            .padding(.top, 14)
            .padding(.bottom, 12)
            .background {
                LinearGradient(
                    colors: [
                        Color.black.opacity(0),
                        Color.black.opacity(0.78),
                        Color.black.opacity(0.96)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
    }

    private var background: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.02, green: 0.03, blue: 0.07),
                    Color(red: 0.03, green: 0.02, blue: 0.05),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [.purple.opacity(0.24), .clear],
                center: .topTrailing,
                startRadius: 20,
                endRadius: 360
            )

            RadialGradient(
                colors: [.cyan.opacity(0.16), .clear],
                center: .bottomLeading,
                startRadius: 12,
                endRadius: 320
            )
        }
    }
}

private struct RoleContinueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .animation(.spring(response: 0.26, dampingFraction: 0.82), value: configuration.isPressed)
    }
}

struct RoleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RoleSelectionView(
                tripName: "Scenic Explorer Trip",
                playerName: "Road Crew"
            )
            .environmentObject(TripSessionViewModel())
        }
    }
}
