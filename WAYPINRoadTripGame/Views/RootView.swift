import SwiftUI

struct RootView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel

    var body: some View {
        NavigationStack {
            if viewModel.session == nil {
                CreateTripView()
            } else {
                ActiveTripDashboardView()
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
