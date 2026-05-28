import SwiftUI

struct TravelStyleSelectionView: View {
    @EnvironmentObject private var viewModel: TripSessionViewModel
    @State private var selectedStyle: TravelStyle?
    @State private var appeared = false

    private let travelStyles = MockTravelStyles.all

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 18) {
                header
                    .padding(.horizontal, 24)
                    .padding(.top, 18)

                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 18) {
                        ForEach(Array(travelStyles.enumerated()), id: \.element.id) { index, style in
                            Button {
                                withAnimation(.spring(response: 0.48, dampingFraction: 0.82)) {
                                    selectedStyle = style
                                }
                            } label: {
                                TravelStyleCard(
                                    travelStyle: style,
                                    isSelected: selectedStyle?.id == style.id
                                )
                            }
                            .buttonStyle(.plain)
                            .offset(y: appeared ? 0 : 28)
                            .opacity(appeared ? 1 : 0)
                            .animation(
                                .spring(response: 0.55, dampingFraction: 0.86)
                                    .delay(Double(index) * 0.055),
                                value: appeared
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 4)
                    .padding(.bottom, 118)
                }
            }

            VStack {
                Spacer()
                beginButton
                    .padding(.horizontal, 22)
                    .padding(.bottom, 22)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .preferredColorScheme(.dark)
        .onAppear {
            appeared = true
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Choose your road")
                .font(.system(size: 42, weight: .black, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.82)

            Text("Set the personality of this trip before the crew rolls out.")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.68))
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var beginButton: some View {
        Button {
            guard let selectedStyle else {
                return
            }

            viewModel.beginAdventure(with: selectedStyle)
        } label: {
            HStack {
                Text("Begin Adventure")
                    .font(.headline.weight(.bold))

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.headline.weight(.black))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 22)
            .frame(height: 62)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(selectedStyle == nil ? .white.opacity(0.12) : .cyan.opacity(0.82))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(.white.opacity(selectedStyle == nil ? 0.1 : 0.28), lineWidth: 1)
                    )
                    .shadow(color: .cyan.opacity(selectedStyle == nil ? 0 : 0.5), radius: 28, x: 0, y: 12)
            )
        }
        .disabled(selectedStyle == nil)
        .buttonStyle(TravelStyleBeginButtonStyle())
    }

    private var background: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.03, green: 0.05, blue: 0.09),
                    Color(red: 0.02, green: 0.02, blue: 0.04),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [.cyan.opacity(0.24), .clear],
                center: .topTrailing,
                startRadius: 20,
                endRadius: 380
            )

            RadialGradient(
                colors: [.orange.opacity(0.16), .clear],
                center: .bottomLeading,
                startRadius: 10,
                endRadius: 320
            )
        }
    }
}

private struct TravelStyleBeginButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .animation(.spring(response: 0.26, dampingFraction: 0.82), value: configuration.isPressed)
    }
}

struct TravelStyleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TravelStyleSelectionView()
                .environmentObject(TripSessionViewModel())
        }
    }
}
