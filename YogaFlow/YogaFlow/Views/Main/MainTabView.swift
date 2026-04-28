import SwiftUI

struct MainTabView: View {
    @Bindable var coordinator: AppCoordinator

    var body: some View {
        ZStack {
            TabView(selection: $coordinator.selectedTab) {
                HomeView(
                    viewModel: HomeViewModel(repository: coordinator.repository),
                    coordinator: coordinator
                )
                .tabItem { Label(AppTab.home.title, systemImage: AppTab.home.icon) }
                .tag(AppTab.home)

                PlaceholderTabView(title: "Library", icon: "play.rectangle")
                    .tabItem { Label(AppTab.library.title, systemImage: AppTab.library.icon) }
                    .tag(AppTab.library)

                PlaceholderTabView(title: "Practice", icon: "figure.yoga")
                    .tabItem { Label(AppTab.practice.title, systemImage: AppTab.practice.icon) }
                    .tag(AppTab.practice)

                PlaceholderTabView(title: "Stats", icon: "chart.bar")
                    .tabItem { Label(AppTab.stats.title, systemImage: AppTab.stats.icon) }
                    .tag(AppTab.stats)

                ProfileView(
                    viewModel: ProfileViewModel(repository: coordinator.repository),
                    coordinator: coordinator
                )
                .tabItem { Label(AppTab.profile.title, systemImage: AppTab.profile.icon) }
                .tag(AppTab.profile)
            }

            if let selectedSession = coordinator.selectedSession {
                DetailView(
                    viewModel: DetailViewModel(session: selectedSession),
                    coordinator: coordinator
                )
                .transition(.move(edge: .trailing))
                .zIndex(2)
            }
        }
        .animation(.snappy, value: coordinator.selectedSession)
    }
}

private struct PlaceholderTabView: View {
    let title: String
    let icon: String

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: icon)
                .font(.system(size: 44, weight: .medium))
                .foregroundStyle(YogaFlowTheme.brandDeep)
                .frame(width: 96, height: 96)
                .background(YogaFlowTheme.mintSoft)
                .clipShape(RoundedRectangle(cornerRadius: 28))

            Text(title)
                .font(.system(size: 34, weight: .semibold))

            Text("This section is wired into the coordinator and ready for repository-backed content.")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .foregroundStyle(YogaFlowTheme.textSecondary)
                .padding(.horizontal, 36)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
