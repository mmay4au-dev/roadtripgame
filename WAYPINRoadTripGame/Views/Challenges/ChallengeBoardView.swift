import SwiftUI

struct ChallengeBoardView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel

    enum DisplayMode {
        case standalone
        case embedded
    }

    let displayMode: DisplayMode

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    init(displayMode: DisplayMode = .standalone) {
        self.displayMode = displayMode
    }

    var body: some View {
        switch displayMode {
        case .standalone:
            standaloneBoard
        case .embedded:
            boardContent
        }
    }

    private var standaloneBoard: some View {
        ZStack {
            boardBackground
                .ignoresSafeArea()

            ScrollView {
                boardContent
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 120)
            }
        }
        .navigationTitle("Challenge Board")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var boardContent: some View {
        VStack(alignment: .leading, spacing: 18) {
            boardSwitcher

            if let board = viewModel.activeChallengeBoard {
                ChallengeProgressHeader(board: board, playerScore: viewModel.currentScore)

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(board.items) { item in
                        ClaimableItemCard(
                            item: item,
                            accentColor: board.category.accentColor
                        ) {
                            viewModel.claimItem(item, on: board)
                        }
                    }
                }
            }
        }
    }

    private var boardSwitcher: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.challengeBoards) { board in
                    Button {
                        viewModel.selectChallengeBoard(board)
                    } label: {
                        Label(board.title, systemImage: board.category.iconName)
                            .font(.caption.weight(.heavy))
                            .padding(.horizontal, 13)
                            .padding(.vertical, 10)
                            .foregroundStyle(viewModel.activeChallengeBoardID == board.id ? .black : .white.opacity(0.76))
                            .background(
                                viewModel.activeChallengeBoardID == board.id ? board.category.accentColor : .white.opacity(0.09),
                                in: Capsule()
                            )
                            .overlay {
                                Capsule()
                                    .stroke(.white.opacity(0.12), lineWidth: 1)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var boardBackground: some View {
        ZStack {
            Color(red: 0.02, green: 0.04, blue: 0.08)

            LinearGradient(
                colors: [
                    .cyan.opacity(0.2),
                    .clear,
                    .orange.opacity(0.14)
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

struct ChallengeBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChallengeBoardView()
                .environmentObject(TripSessionViewModel())
        }
    }
}
