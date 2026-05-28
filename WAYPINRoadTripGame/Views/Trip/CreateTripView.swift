import MapKit
import SwiftUI

struct CreateTripView: View {
    @State private var cameraRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.2, longitude: -87.6),
        span: MKCoordinateSpan(latitudeDelta: 9.5, longitudeDelta: 13.5)
    )
    @State private var selectedFeedItemID: UUID?

    private let mapPins = MockMapPin.samples
    private let feedItems = MockRoadFeedItem.samples

    var body: some View {
        ZStack {
            Map(coordinateRegion: $cameraRegion, annotationItems: mapPins) { pin in
                MapAnnotation(coordinate: pin.coordinate) {
                    MapPulsePin(iconName: pin.iconName)
                }
            }
            .ignoresSafeArea()
            .colorScheme(.dark)

            AtmosphericRoadOverlay()
                .ignoresSafeArea()
                .allowsHitTesting(false)

            LinearGradient(
                colors: [
                    Color.black.opacity(0.75),
                    Color.black.opacity(0.28),
                    Color.black.opacity(0.82)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                heroSection
                    .padding(.horizontal, 24)
                    .padding(.top, 22)

                Spacer(minLength: 28)

                actionDeck
                    .padding(.horizontal, 18)

                liveRoadFeed
                    .padding(.top, 22)
                    .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("WAYPIN")
                .font(.system(size: 52, weight: .black, design: .rounded))
                .foregroundStyle(.white)
                .shadow(color: .cyan.opacity(0.45), radius: 18, x: 0, y: 4)

            Text("The road is the game.")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white.opacity(0.82))
        }
        .accessibilityElement(children: .combine)
    }

    private var actionDeck: some View {
        VStack(spacing: 12) {
            NavigationLink {
                TravelStyleSelectionView()
            } label: {
                AdventureActionCard(
                    title: "Start Road Trip",
                    subtitle: "Launch a local crew session",
                    iconName: "car.2.fill",
                    accentColor: .cyan
                )
            }
            .buttonStyle(AdventureCardButtonStyle())

            HStack(spacing: 12) {
                NavigationLink {
                    RoleSelectionView(
                        tripName: "WAYPIN Crew",
                        playerName: "Passenger"
                    )
                } label: {
                    AdventureActionCard(
                        title: "Join Crew",
                        subtitle: "Mock code flow",
                        iconName: "person.3.fill",
                        accentColor: .orange,
                        isCompact: true
                    )
                }
                .buttonStyle(AdventureCardButtonStyle())

                Button {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.82)) {
                        selectedFeedItemID = feedItems.randomElement()?.id
                    }
                } label: {
                    AdventureActionCard(
                        title: "Explore Nearby",
                        subtitle: "Preview live routes",
                        iconName: "location.north.line.fill",
                        accentColor: .green,
                        isCompact: true
                    )
                }
                .buttonStyle(AdventureCardButtonStyle())
            }
        }
    }

    private var liveRoadFeed: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Live Road Feed", systemImage: "dot.radiowaves.left.and.right")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                Text("MOCK")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.68))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.white.opacity(0.08), in: Capsule())
            }
            .padding(.horizontal, 24)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(feedItems) { item in
                        RoadFeedCard(
                            item: item,
                            isHighlighted: selectedFeedItemID == item.id
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 2)
            }
        }
    }
}

private struct AdventureActionCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let accentColor: Color
    var isCompact = false

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: iconName)
                .font(.system(size: isCompact ? 20 : 26, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: isCompact ? 38 : 48, height: isCompact ? 38 : 48)
                .background(
                    Circle()
                        .fill(accentColor.opacity(0.24))
                        .shadow(color: accentColor.opacity(0.75), radius: 18)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(isCompact ? .headline : .title3.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.82)

                Text(subtitle)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.white.opacity(0.68))
                    .lineLimit(2)
            }

            Spacer(minLength: 8)

            if !isCompact {
                Image(systemName: "arrow.up.right")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.white.opacity(0.76))
            }
        }
        .frame(maxWidth: .infinity, minHeight: isCompact ? 104 : 92, alignment: .leading)
        .padding(isCompact ? 16 : 18)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.34), accentColor.opacity(0.28), .white.opacity(0.06)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: accentColor.opacity(0.18), radius: 28, x: 0, y: 10)
        )
    }
}

private struct AdventureCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .brightness(configuration.isPressed ? 0.08 : 0)
            .animation(.spring(response: 0.28, dampingFraction: 0.78), value: configuration.isPressed)
    }
}

private struct RoadFeedCard: View {
    let item: MockRoadFeedItem
    let isHighlighted: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: item.iconName)
                .font(.headline)
                .foregroundStyle(item.accentColor)
                .frame(width: 28, height: 28)
                .background(item.accentColor.opacity(0.14), in: Circle())

            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .lineLimit(3)

                Text(item.region)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.white.opacity(0.58))
            }
        }
        .frame(width: 238, alignment: .topLeading)
        .frame(minHeight: 112, alignment: .topLeading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(isHighlighted ? item.accentColor.opacity(0.86) : .white.opacity(0.14), lineWidth: 1)
                )
                .shadow(color: isHighlighted ? item.accentColor.opacity(0.34) : .black.opacity(0.28), radius: 22, x: 0, y: 12)
        )
        .scaleEffect(isHighlighted ? 1.035 : 1)
        .animation(.spring(response: 0.42, dampingFraction: 0.8), value: isHighlighted)
    }
}

private struct MapPulsePin: View {
    let iconName: String
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(.cyan.opacity(0.42), lineWidth: 2)
                .frame(width: pulse ? 48 : 18, height: pulse ? 48 : 18)
                .opacity(pulse ? 0 : 1)

            Image(systemName: iconName)
                .font(.caption.weight(.bold))
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(.cyan.opacity(0.62), in: Circle())
                .shadow(color: .cyan.opacity(0.78), radius: 12)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 2.4).repeatForever(autoreverses: false)) {
                pulse = true
            }
        }
    }
}

private struct AtmosphericRoadOverlay: View {
    @State private var glow = false

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RoadLine(progress: glow ? 1 : 0)
                    .stroke(
                        LinearGradient(
                            colors: [.cyan.opacity(0.0), .cyan.opacity(0.42), .orange.opacity(0.28)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                    )
                    .blur(radius: 2)
                    .frame(width: proxy.size.width, height: proxy.size.height)

                RadialGradient(
                    colors: [.cyan.opacity(0.2), .clear],
                    center: .bottomTrailing,
                    startRadius: 12,
                    endRadius: proxy.size.width * 0.9
                )
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4.8).repeatForever(autoreverses: true)) {
                glow = true
            }
        }
    }
}

private struct RoadLine: Shape {
    var progress: CGFloat

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX - 20, y: rect.height * 0.68))
        path.addCurve(
            to: CGPoint(x: rect.width * 0.58, y: rect.height * 0.52),
            control1: CGPoint(x: rect.width * 0.22, y: rect.height * 0.74),
            control2: CGPoint(x: rect.width * 0.28, y: rect.height * 0.42)
        )
        path.addCurve(
            to: CGPoint(x: rect.maxX + 40, y: rect.height * 0.38),
            control1: CGPoint(x: rect.width * 0.76, y: rect.height * 0.62),
            control2: CGPoint(x: rect.width * 0.82, y: rect.height * 0.31)
        )
        return path.trimmedPath(from: 0, to: 0.55 + progress * 0.45)
    }
}

private struct MockMapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let iconName: String

    static let samples = [
        MockMapPin(coordinate: CLLocationCoordinate2D(latitude: 30.39, longitude: -88.88), iconName: "sun.max.fill"),
        MockMapPin(coordinate: CLLocationCoordinate2D(latitude: 36.16, longitude: -86.78), iconName: "fork.knife"),
        MockMapPin(coordinate: CLLocationCoordinate2D(latitude: 34.73, longitude: -86.59), iconName: "binoculars.fill"),
        MockMapPin(coordinate: CLLocationCoordinate2D(latitude: 29.95, longitude: -90.07), iconName: "music.note")
    ]
}

private struct MockRoadFeedItem: Identifiable {
    let id = UUID()
    let title: String
    let region: String
    let iconName: String
    let accentColor: Color

    static let samples = [
        MockRoadFeedItem(
            title: "Crew discovered hidden diner near Nashville",
            region: "I-65 North",
            iconName: "fork.knife",
            accentColor: .orange
        ),
        MockRoadFeedItem(
            title: "Sunset challenge active on Gulf Coast",
            region: "US-90 Scenic",
            iconName: "sunset.fill",
            accentColor: .pink
        ),
        MockRoadFeedItem(
            title: "Route 66 activity increasing",
            region: "Historic corridor",
            iconName: "road.lanes",
            accentColor: .cyan
        ),
        MockRoadFeedItem(
            title: "Historic highway event nearby",
            region: "Old Federal Road",
            iconName: "building.columns.fill",
            accentColor: .green
        )
    ]
}

struct CreateTripView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateTripView()
                .environmentObject(TripSessionViewModel())
        }
    }
}
