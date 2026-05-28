import SwiftUI

struct ChallengeListView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.challenges) { challenge in
                        ChallengeRow(challenge: challenge)
                    }
                } header: {
                    Text("Mock Challenges")
                } footer: {
                    Text("Challenge completion is local-only for the MVP.")
                }
            }
            .navigationTitle("Challenges")
        }
    }
}

private struct ChallengeRow: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel
    let challenge: RoadTripChallenge

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ChallengeSummaryRow(challenge: challenge)

            Text(challenge.prompt)
                .font(.body)
                .foregroundStyle(.secondary)

            Button {
                viewModel.completeChallenge(challenge)
            } label: {
                Label(
                    viewModel.isChallengeCompleted(challenge) ? "Completed" : "Complete Challenge",
                    systemImage: viewModel.isChallengeCompleted(challenge) ? "checkmark.circle.fill" : "plus.circle"
                )
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isChallengeCompleted(challenge))
        }
        .padding(.vertical, 8)
    }
}

struct ChallengeSummaryRow: View {
    let challenge: RoadTripChallenge

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(challenge.title)
                    .font(.headline)
                Text("\(challenge.category.displayName) · \(challenge.difficulty.displayName)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("+\(challenge.points)")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.blue)
        }
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
            .environmentObject(TripSessionViewModel())
    }
}
