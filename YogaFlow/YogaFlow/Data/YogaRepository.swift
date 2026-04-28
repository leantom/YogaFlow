import Foundation

protocol YogaAPIClient {
    func fetchGoals() async throws -> [YogaGoal]
    func fetchLevels() async throws -> [ExperienceLevel]
    func fetchStyles() async throws -> [PracticeStyle]
    func fetchRecommendedSessions() async throws -> [FlowSession]
}

protocol YogaMongoStore {
    func fetchProfile() async throws -> UserProfile
    func fetchPlan() async throws -> YogaPlan
    func fetchHistory() async throws -> [PracticeHistory]
}

protocol YogaRepository {
    func goals() async throws -> [YogaGoal]
    func levels() async throws -> [ExperienceLevel]
    func styles() async throws -> [PracticeStyle]
    func recommendedSessions() async throws -> [FlowSession]
    func profile() async throws -> UserProfile
    func plan() async throws -> YogaPlan
    func history() async throws -> [PracticeHistory]
}

struct DefaultYogaRepository: YogaRepository {
    let api: YogaAPIClient
    let mongo: YogaMongoStore

    func goals() async throws -> [YogaGoal] { try await api.fetchGoals() }
    func levels() async throws -> [ExperienceLevel] { try await api.fetchLevels() }
    func styles() async throws -> [PracticeStyle] { try await api.fetchStyles() }
    func recommendedSessions() async throws -> [FlowSession] { try await api.fetchRecommendedSessions() }
    func profile() async throws -> UserProfile { try await mongo.fetchProfile() }
    func plan() async throws -> YogaPlan { try await mongo.fetchPlan() }
    func history() async throws -> [PracticeHistory] { try await mongo.fetchHistory() }
}

enum YogaRepositoryFactory {
    static func makeMockRepository() -> YogaRepository {
        DefaultYogaRepository(api: MockYogaAPIClient(), mongo: MockYogaMongoStore())
    }
}
