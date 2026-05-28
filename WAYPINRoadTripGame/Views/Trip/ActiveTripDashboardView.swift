import SwiftUI

struct ActiveTripDashboardView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel

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
        List {
            if let session = viewModel.session {
                Section("Active Trip") {
                    LabeledContent("Trip", value: session.name)
                    LabeledContent("Join code", value: session.code)
                    LabeledContent("Score", value: "\(viewModel.currentScore)")
                }

                if let travelStyle = viewModel.selectedTravelStyle {
                    Section("Travel Style") {
                        Label(travelStyle.title, systemImage: travelStyle.iconName)
                        Text(travelStyle.subtitle)
                            .foregroundStyle(.secondary)
                    }
                }

                if let participant = viewModel.currentParticipant {
                    Section("You") {
                        LabeledContent("Name", value: participant.displayName)
                        LabeledContent("Role", value: participant.role.displayName)
                    }
                }
            }

            Section("Next Up") {
                ForEach(viewModel.challenges.prefix(3)) { challenge in
                    ChallengeSummaryRow(challenge: challenge)
                }
            }
        }
        .navigationTitle("Active Trip")
    }
}

struct ActiveTripDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TripSessionViewModel()
        viewModel.playerName = "Passenger"
        viewModel.createTrip()

        return NavigationStack {
            ActiveTripDashboardView()
                .environmentObject(viewModel)
        }
    }
}
