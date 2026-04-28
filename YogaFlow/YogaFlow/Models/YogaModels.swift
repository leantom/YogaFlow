import Foundation

struct YogaGoal: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
}

struct ExperienceLevel: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
}

struct PracticeStyle: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
}

struct FlowSession: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let duration: Int
    let level: String
    let style: String
    let intensity: String
    let imageKind: SessionImageKind
    let imageName: String
    let description: String
}

enum SessionImageKind: Hashable {
    case mountain
    case studio
    case sideBend
    case strength
    case warrior
}

extension FlowSession {
    static let detailPreview = FlowSession(
        id: "solar",
        title: "Solar Power Vinyasa",
        subtitle: "Advanced - Strength",
        duration: 45,
        level: "Intermediate",
        style: "Vinyasa",
        intensity: "Moderate",
        imageKind: .warrior,
        imageName: "FlowSolar",
        description: "Ignite your inner fire and awaken your senses with a fluid Vinyasa flow. Designed to be practiced as the sun rises, this session focuses on rhythmic breathing and continuous movement to build heat, increase flexibility, and clear the mind for the day ahead."
    )
}

struct PracticeHistory: Identifiable, Hashable {
    let id: String
    let title: String
    let metadata: String
    let icon: String
}

struct UserProfile: Hashable {
    let name: String
    let tier: String
    let memberSince: String
    let email: String
    let focusArea: String
    let level: String
    let streak: Int
    let sessions: Int
    let practicedHours: Int
}

struct YogaPlan: Hashable {
    let userName: String
    let goal: YogaGoal
    let level: ExperienceLevel
    let dailyMinutes: Int
    let style: String
}
