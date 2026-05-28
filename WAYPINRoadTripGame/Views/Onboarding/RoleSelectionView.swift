import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel
    @Environment(\.dismiss) private var dismiss

    let tripName: String
    let playerName: String

    var body: some View {
        List {
            Section("Passenger roles") {
                ForEach(PlayerRole.allCases.filter(\.isPassengerFirst)) { role in
                    roleButton(for: role)
                }
            }

            Section {
                roleButton(for: .driver)
            } header: {
                Text("Driver mode")
            } footer: {
                Text("Driver mode is included as a placeholder only. MVP gameplay is designed for passengers.")
            }
        }
        .navigationTitle("Choose Role")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Start") {
                    viewModel.playerName = playerName
                    viewModel.createTrip(named: tripName)
                    dismiss()
                }
            }
        }
    }

    private func roleButton(for role: PlayerRole) -> some View {
        Button {
            viewModel.selectedRole = role
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(role.displayName)
                        .foregroundStyle(.primary)
                    Text(role.description)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if viewModel.selectedRole == role {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

struct RoleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RoleSelectionView(
                tripName: "WAYPIN Road Trip",
                playerName: "Passenger"
            )
            .environmentObject(TripSessionViewModel())
        }
    }
}
