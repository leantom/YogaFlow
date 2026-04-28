import Observation
import Foundation

@Observable
final class SplashViewModel {
    var progress = 0.25
}

@Observable
final class OnboardingViewModel {
    var goals: [YogaGoal] = []
    var levels: [ExperienceLevel] = []
    var selectedGoalID = "strength"
    var selectedLevelID = "intermediate"
    var isLoading = false

    private let repository: YogaRepository

    init(repository: YogaRepository) {
        self.repository = repository
    }

    @MainActor
    func loadGoals() async {
        guard goals.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        goals = (try? await repository.goals()) ?? []
    }

    @MainActor
    func loadLevels() async {
        guard levels.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        levels = (try? await repository.levels()) ?? []
    }
}

@Observable
final class PlanSummaryViewModel {
    var plan: YogaPlan?

    private let repository: YogaRepository

    init(repository: YogaRepository) {
        self.repository = repository
    }

    @MainActor
    func load() async {
        plan = try? await repository.plan()
    }
}

@Observable
final class HomeViewModel {
    var styles: [PracticeStyle] = []
    var sessions: [FlowSession] = []

    private let repository: YogaRepository

    init(repository: YogaRepository) {
        self.repository = repository
    }

    @MainActor
    func load() async {
        async let styles = repository.styles()
        async let sessions = repository.recommendedSessions()

        self.styles = (try? await styles) ?? []
        self.sessions = (try? await sessions) ?? []
    }
}

@Observable
final class DetailViewModel {
    let session: FlowSession

    init(session: FlowSession) {
        self.session = session
    }
}

@Observable
final class ProfileViewModel {
    var profile: UserProfile?
    var history: [PracticeHistory] = []
    var remindersEnabled = true
    var achievementsEnabled = true
    var newsletterEnabled = false

    private let repository: YogaRepository

    init(repository: YogaRepository) {
        self.repository = repository
    }

    @MainActor
    func load() async {
        async let profile = repository.profile()
        async let history = repository.history()

        self.profile = try? await profile
        self.history = (try? await history) ?? []
    }
}
