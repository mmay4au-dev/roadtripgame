import SwiftUI

struct RootView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel

    var body: some View {
        NavigationStack {
            if viewModel.session == nil {
                CreateTripView()
            } else {
                ActiveTripDashboardView(
                    tripName: viewModel.session?.name ?? "WAYPIN Road Trip",
                    selectedTravelStyle: viewModel.selectedTravelStyle,
                    selectedPlayerRole: viewModel.selectedRole,
                    playerName: viewModel.currentParticipant?.displayName ?? viewModel.playerName
                )
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(TripSessionViewModel())
    }
}
