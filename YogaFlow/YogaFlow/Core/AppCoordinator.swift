import Observation
import SwiftUI

enum AppRoute {
    case splash
    case onboardingGoal
    case onboardingLevel
    case planSummary
    case main
}

enum AppTab: String, CaseIterable, Identifiable {
    case home
    case library
    case practice
    case stats
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .library: "Library"
        case .practice: "Practice"
        case .stats: "Stats"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: "house"
        case .library: "play.rectangle"
        case .practice: "figure.yoga"
        case .stats: "chart.bar"
        case .profile: "person"
        }
    }
}

@Observable
final class AppCoordinator {
    var route: AppRoute
    var selectedTab: AppTab = .home
    var selectedSession: FlowSession?

    let repository: YogaRepository

    init(repository: YogaRepository, route: AppRoute = .splash, selectedTab: AppTab = .home) {
        self.repository = repository
        self.route = route
        self.selectedTab = selectedTab
    }

    func startOnboarding() {
        route = .onboardingGoal
    }

    func showLevelStep() {
        route = .onboardingLevel
    }

    func showPlanSummary() {
        route = .planSummary
    }

    func showMain(tab: AppTab = .home) {
        selectedTab = tab
        selectedSession = nil
        route = .main
    }

    func showDetail(_ session: FlowSession) {
        selectedSession = session
    }

    func closeDetail() {
        selectedSession = nil
    }
}

enum AppLaunchScreen {
    static func coordinator(repository: YogaRepository) -> AppCoordinator {
        let args = CommandLine.arguments
        guard let valueIndex = args.firstIndex(of: "-YogaFlowScreen").map({ args.index(after: $0) }),
              args.indices.contains(valueIndex) else {
            return AppCoordinator(repository: repository)
        }

        switch args[valueIndex] {
        case "goal":
            return AppCoordinator(repository: repository, route: .onboardingGoal)
        case "level":
            return AppCoordinator(repository: repository, route: .onboardingLevel)
        case "plan":
            return AppCoordinator(repository: repository, route: .planSummary)
        case "home":
            return AppCoordinator(repository: repository, route: .main, selectedTab: .home)
        case "detail":
            let coordinator = AppCoordinator(repository: repository, route: .main, selectedTab: .home)
            coordinator.selectedSession = FlowSession.detailPreview
            return coordinator
        case "profile":
            return AppCoordinator(repository: repository, route: .main, selectedTab: .profile)
        default:
            return AppCoordinator(repository: repository)
        }
    }
}

struct RootCoordinatorView: View {
    @Bindable var coordinator: AppCoordinator

    var body: some View {
        Group {
            switch coordinator.route {
            case .splash:
                SplashView(viewModel: SplashViewModel(), coordinator: coordinator)
            case .onboardingGoal:
                GoalOnboardingView(
                    viewModel: OnboardingViewModel(repository: coordinator.repository),
                    coordinator: coordinator
                )
            case .onboardingLevel:
                LevelOnboardingView(
                    viewModel: OnboardingViewModel(repository: coordinator.repository),
                    coordinator: coordinator
                )
            case .planSummary:
                PlanSummaryView(
                    viewModel: PlanSummaryViewModel(repository: coordinator.repository),
                    coordinator: coordinator
                )
            case .main:
                MainTabView(coordinator: coordinator)
            }
        }
        .tint(YogaFlowTheme.brand)
    }
}
