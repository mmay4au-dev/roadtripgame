import SwiftUI

struct PlaceholderMapView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "map")
                    .font(.system(size: 48))
                    .foregroundStyle(.secondary)
                Text("Map Coming Soon")
                    .font(.title2.weight(.semibold))
                Text("The first MVP keeps route awareness mocked until the app shell is stable.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .navigationTitle("Map")
        }
    }
}

struct PlaceholderMapView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderMapView()
    }
}
