import SwiftUI

struct SharedTimelineView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "clock")
                    .font(.system(size: 48))
                    .foregroundStyle(.secondary)
                Text("Timeline Coming Soon")
                    .font(.title2.weight(.semibold))
                Text("Completed challenges will become shared trip moments in a future phase.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .navigationTitle("Timeline")
        }
    }
}

struct SharedTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        SharedTimelineView()
    }
}
