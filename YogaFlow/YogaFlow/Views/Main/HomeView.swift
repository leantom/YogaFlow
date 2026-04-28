import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    let coordinator: AppCoordinator

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 34) {
                    homeHeader
                    heroSection
                    styleSection
                    recommendedSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 96)
            }
            .background(Color.white)
            .task { await viewModel.load() }
        }
    }

    private var homeHeader: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
            Text("YogaFlow")
                .font(.system(size: 16, weight: .semibold))
            Spacer()
            Circle()
                .fill(YogaFlowTheme.mintSoft)
                .frame(width: 30, height: 30)
                .overlay(Image(systemName: "person.fill").font(.caption))
        }
        .foregroundStyle(YogaFlowTheme.ink)
        .padding(.top, 14)
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("DAILY HIGHLIGHT")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(YogaFlowTheme.brandDeep)
                .padding(.horizontal, 10)
                .frame(height: 24)
                .background(YogaFlowTheme.brand)
                .clipShape(Capsule())

            Text("Morning\nVitality\nFlow")
                .font(.system(size: 45, weight: .semibold))
                .lineSpacing(2)
                .foregroundStyle(YogaFlowTheme.ink)

            Text("A 20-minute energizing Vinyasa sequence designed to awaken your senses and align your breath for the day ahead.")
                .font(.system(size: 15))
                .lineSpacing(6)
                .foregroundStyle(YogaFlowTheme.textSecondary)

            HStack(spacing: 14) {
                Button {
                    if let session = viewModel.sessions.first {
                        coordinator.showDetail(session)
                    }
                } label: {
                    Label("Start Practice", systemImage: "play.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 18)
                        .frame(height: 42)
                        .background(YogaFlowTheme.ink)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)

                Button("Save for Later") {}
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(YogaFlowTheme.ink)
                    .padding(.horizontal, 18)
                    .frame(height: 42)
                    .background(.white)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(YogaFlowTheme.border))
            }

            ReferenceImage(name: "HomeDailyPose", height: 236)
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [YogaFlowTheme.mintSoft.opacity(0.85), .white],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var styleSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Practice by\nStyle")
                        .font(.system(size: 34, weight: .semibold))
                    Text("Find the perfect flow for your current energy.")
                        .font(.system(size: 14))
                        .foregroundStyle(YogaFlowTheme.textSecondary)
                }
                Spacer()
                Button("View all") {}
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(YogaFlowTheme.brandDeep)
            }

            VStack(spacing: 14) {
                ForEach(viewModel.styles) { style in
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(YogaFlowTheme.mintSoft)
                            .frame(width: 42, height: 42)
                            .overlay(Image(systemName: style.icon).foregroundStyle(YogaFlowTheme.brandDeep))

                        VStack(alignment: .leading, spacing: 6) {
                            Text(style.title)
                                .font(.system(size: 17, weight: .semibold))
                            Text(style.subtitle)
                                .font(.system(size: 13))
                                .foregroundStyle(YogaFlowTheme.textTertiary)
                        }
                        Spacer()
                    }
                    .padding(18)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(YogaFlowTheme.border))
                }
            }
        }
    }

    private var recommendedSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recommended\nFlows")
                .font(.system(size: 34, weight: .semibold))

            ForEach(viewModel.sessions) { session in
                Button {
                    coordinator.showDetail(session)
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack(alignment: .bottomTrailing) {
                            ReferenceImage(name: session.imageName, height: 150)
                            Text("\(session.duration) min")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 8)
                                .frame(height: 22)
                                .background(.black.opacity(0.65))
                                .clipShape(Capsule())
                                .padding(10)
                        }
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(session.title)
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundStyle(YogaFlowTheme.ink)
                                Text(session.subtitle)
                                    .font(.system(size: 13))
                                    .foregroundStyle(YogaFlowTheme.textSecondary)
                            }
                            Spacer()
                            Image(systemName: "ellipsis")
                                .foregroundStyle(YogaFlowTheme.ink)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}
