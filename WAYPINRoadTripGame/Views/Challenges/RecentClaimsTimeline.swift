import SwiftUI

struct RecentClaimsTimeline: View {
    let events: [ClaimEvent]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label("Recent Claims", systemImage: "flag.checkered")
                    .font(.headline.weight(.heavy))
                    .foregroundStyle(.white)
                Spacer()
            }

            if events.isEmpty {
                Text("No claims yet. The first sharp-eyed passenger gets the opening points.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.58))
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                VStack(spacing: 10) {
                    ForEach(events.prefix(4)) { event in
                        HStack(spacing: 12) {
                            Circle()
                                .fill(.yellow.opacity(0.18))
                                .overlay {
                                    Image(systemName: "bolt.fill")
                                        .font(.caption.weight(.black))
                                        .foregroundStyle(.yellow)
                                }
                                .frame(width: 34, height: 34)

                            VStack(alignment: .leading, spacing: 3) {
                                Text(event.message)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.white.opacity(0.9))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(event.createdAt, style: .time)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.48))
                            }

                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
        .padding(16)
        .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        }
    }
}
