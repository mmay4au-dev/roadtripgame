import SwiftUI

struct ActiveTripDashboardView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel

    let tripName: String
    let selectedTravelStyle: TravelStyle?
    let selectedPlayerRole: PlayerRole
    let playerName: String

    init(
        tripName: String = "WAYPIN Road Trip",
        selectedTravelStyle: TravelStyle? = nil,
        selectedPlayerRole: PlayerRole = .navigator,
        playerName: String = "Passenger"
    ) {
        self.tripName = tripName
        self.selectedTravelStyle = selectedTravelStyle
        self.selectedPlayerRole = selectedPlayerRole
        self.playerName = playerName
    }

    var body: some View {
        TabView {
            dashboard
                .tabItem {
                    Label("Trip", systemImage: "car.2.fill")
                }

            ChallengeListView()
                .tabItem {
                    Label("Challenges", systemImage: "checklist")
                }

            PlaceholderMapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }

            SharedTimelineView()
                .tabItem {
                    Label("Timeline", systemImage: "clock.fill")
                }
        }
        .navigationBarBackButtonHidden()
    }

    private var dashboard: some View {
        ZStack {
            dashboardBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("WAYPIN Trip Dashboard")
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, 4)

                    tripHero

                    mockTripSnapshot

                    ChallengeBoardView(displayMode: .embedded)

                    RecentClaimsTimeline(events: viewModel.claimEvents)
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 140)
            }
        }
        .navigationTitle("Active Trip")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var tripHero: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(tripName)
                        .font(.title.weight(.heavy))
                        .foregroundStyle(.white)
                    Text("Crew code \(viewModel.session?.code ?? "WYPIN")")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.62))
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(viewModel.currentScore)")
                        .font(.title.weight(.black))
                        .foregroundStyle(.yellow)
                    Text("points")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white.opacity(0.54))
                }
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                DashboardPill(iconName: "person.fill", title: "Player", value: playerName.isEmpty ? "Passenger" : playerName)

                DashboardPill(
                    iconName: selectedPlayerRole.iconName,
                    title: "Role",
                    value: selectedPlayerRole.displayName
                )

                if let travelStyle = selectedTravelStyle {
                    DashboardPill(iconName: travelStyle.iconName, title: "Vibe", value: travelStyle.title)
                } else {
                    DashboardPill(iconName: "sparkles", title: "Vibe", value: "Road Trip")
                }
            }

            if let roleOption = viewModel.selectedRoleOption {
                Label(roleOption.challengeFocus, systemImage: roleOption.iconName)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.7))
            }
        }
        .padding(18)
        .background(.ultraThinMaterial.opacity(0.7), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(.white.opacity(0.13), lineWidth: 1)
        }
    }

    private var mockTripSnapshot: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Trip Snapshot")
                .font(.headline.weight(.heavy))
                .foregroundStyle(.white)

            HStack(spacing: 10) {
                DashboardPill(iconName: "star.fill", title: "Score", value: "\(viewModel.currentScore)")
                DashboardPill(iconName: "checkmark.seal.fill", title: "Completed", value: "\(viewModel.completedClaimCount) claims")
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Recent Activity")
                    .font(.caption.weight(.black))
                    .foregroundStyle(.yellow)

                Text(viewModel.claimEvents.first?.message ?? "Crew joined the trip and is ready to start claiming challenges.")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.72))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .padding(16)
        .background(.ultraThinMaterial.opacity(0.58), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.11), lineWidth: 1)
        }
    }

    private var dashboardBackground: some View {
        ZStack {
            Color(red: 0.015, green: 0.025, blue: 0.05)

            LinearGradient(
                colors: [
                    .cyan.opacity(0.18),
                    .clear,
                    .orange.opacity(0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [.yellow.opacity(0.16), .clear],
                center: .topTrailing,
                startRadius: 20,
                endRadius: 360
            )
        }
    }
}

private struct DashboardPill: View {
    let iconName: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.caption.weight(.bold))
                .foregroundStyle(.yellow)
            VStack(alignment: .leading, spacing: 1) {
                Text(title.uppercased())
                    .font(.caption2.weight(.black))
                    .foregroundStyle(.white.opacity(0.46))
                Text(value)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.86))
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

struct ActiveTripDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TripSessionViewModel()
        viewModel.playerName = "Passenger"
        viewModel.createTrip()

        return NavigationStack {
            ActiveTripDashboardView(
                tripName: "Scenic Explorer Trip",
                selectedTravelStyle: MockTravelStyles.all.first,
                selectedPlayerRole: .spotter,
                playerName: "Passenger"
            )
                .environmentObject(viewModel)
        }
    }
}
