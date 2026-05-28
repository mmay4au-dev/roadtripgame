import SwiftUI

@main
struct WAYPINRoadTripGameApp: App {
    @StateObject private var tripSessionViewModel = TripSessionViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(tripSessionViewModel)
        }
    }
}
