import Foundation

struct MockYogaAPIClient: YogaAPIClient {
    func fetchGoals() async throws -> [YogaGoal] {
        [
            YogaGoal(id: "flexibility", title: "Improve Flexibility", subtitle: "Gentle stretches to open your body.", icon: "figure.flexibility"),
            YogaGoal(id: "strength", title: "Build Strength", subtitle: "Powerful flows to tone your muscles.", icon: "dumbbell"),
            YogaGoal(id: "stress", title: "Reduce Stress", subtitle: "Mindful breathing and calming poses.", icon: "wind"),
            YogaGoal(id: "sleep", title: "Better Sleep", subtitle: "Relaxing evening routines for rest.", icon: "moon")
        ]
    }

    func fetchLevels() async throws -> [ExperienceLevel] {
        [
            ExperienceLevel(id: "beginner", title: "Beginner", subtitle: "I'm new to yoga", icon: "face.smiling"),
            ExperienceLevel(id: "intermediate", title: "Intermediate", subtitle: "I know the basics", icon: "figure.mind.and.body"),
            ExperienceLevel(id: "advanced", title: "Advanced", subtitle: "I have a consistent practice", icon: "dumbbell")
        ]
    }

    func fetchStyles() async throws -> [PracticeStyle] {
        [
            PracticeStyle(id: "hatha", title: "Hatha", subtitle: "Classic postures held for focus and balance.", icon: "leaf"),
            PracticeStyle(id: "vinyasa", title: "Vinyasa", subtitle: "Flowing movements synchronized with breath.", icon: "wind"),
            PracticeStyle(id: "yin", title: "Yin", subtitle: "Deep stretching for connective tissues.", icon: "figure.cooldown"),
            PracticeStyle(id: "restorative", title: "Restorative", subtitle: "Relaxation-focused poses using props.", icon: "sparkle")
        ]
    }

    func fetchRecommendedSessions() async throws -> [FlowSession] {
        [
            FlowSession(id: "evening", title: "Evening Deep Stretch", subtitle: "Beginner - Flexibility", duration: 15, level: "Beginner", style: "Yin", intensity: "Low", imageKind: .strength, imageName: "FlowEvening", description: "A grounded evening practice designed to release tension through long holds and breath-led mobility."),
            FlowSession(id: "solar", title: "Solar Power Vinyasa", subtitle: "Advanced - Strength", duration: 45, level: "Advanced", style: "Vinyasa", intensity: "High", imageKind: .warrior, imageName: "FlowSolar", description: "Ignite your inner fire and awaken your senses with a fluid Vinyasa flow. Designed to be practiced as the sun rises, this session focuses on rhythmic breathing and continuous movement."),
            FlowSession(id: "core", title: "Focused Core Alignment", subtitle: "Intermediate - Core", duration: 30, level: "Intermediate", style: "Hatha", intensity: "Moderate", imageKind: .sideBend, imageName: "FlowCore", description: "Targeted movement to strengthen the deep abdominal wall and improve posture.")
        ]
    }
}

struct MockYogaMongoStore: YogaMongoStore {
    func fetchProfile() async throws -> UserProfile {
        UserProfile(
            name: "Elena Rodriguez",
            tier: "Flow Master",
            memberSince: "Jan 2023",
            email: "elena.rodriguez@flow.com",
            focusArea: "Vinyasa & Mindfulness",
            level: "Intermediate",
            streak: 12,
            sessions: 156,
            practicedHours: 48
        )
    }

    func fetchPlan() async throws -> YogaPlan {
        YogaPlan(
            userName: "Sarah",
            goal: YogaGoal(id: "stress", title: "Stress Relief", subtitle: "Mindful breathing and calming poses.", icon: "target"),
            level: ExperienceLevel(id: "intermediate", title: "Intermediate", subtitle: "I know the basics", icon: "chart.bar"),
            dailyMinutes: 15,
            style: "Hatha Yoga"
        )
    }

    func fetchHistory() async throws -> [PracticeHistory] {
        [
            PracticeHistory(id: "sun", title: "Morning Sun Salutation", metadata: "Oct 24 - 20 mins - Vinyasa", icon: "figure.yoga"),
            PracticeHistory(id: "rest", title: "Deep Rest Meditation", metadata: "Oct 23 - 15 mins - Yin", icon: "moon"),
            PracticeHistory(id: "power", title: "Power Flow Advanced", metadata: "Oct 21 - 45 mins - Hatha", icon: "bolt")
        ]
    }
}
