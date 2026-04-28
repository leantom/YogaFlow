import SwiftUI

struct ProfileView: View {
    @State var viewModel: ProfileViewModel
    let coordinator: AppCoordinator

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                topBar

                if let profile = viewModel.profile {
                    profileHero(profile)
                    accountInfo(profile)
                    practiceHistory
                    notifications
                    logoutButton
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 96)
        }
        .background(Color.white)
        .task { await viewModel.load() }
    }

    private var topBar: some View {
        HStack {
            Text("YogaFlow")
                .font(.system(size: 22, weight: .semibold))
            Spacer()
            Image(systemName: "bell")
            Image(systemName: "gearshape")
            Circle()
                .fill(YogaFlowTheme.mintSoft)
                .frame(width: 34, height: 34)
                .overlay(Image(systemName: "person.fill").font(.caption))
        }
        .foregroundStyle(YogaFlowTheme.ink)
        .padding(.top, 18)
    }

    private func profileHero(_ profile: UserProfile) -> some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(.white)
                    .frame(width: 104, height: 104)
                    .overlay(Circle().stroke(.white, lineWidth: 5))
                    .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
                    .overlay(Image(systemName: "person.crop.circle.fill").font(.system(size: 76)).foregroundStyle(YogaFlowTheme.textSecondary, YogaFlowTheme.mintSoft))
                Circle()
                    .fill(YogaFlowTheme.brand)
                    .frame(width: 28, height: 28)
                    .overlay(Image(systemName: "pencil").font(.caption).foregroundStyle(.white))
            }

            VStack(spacing: 4) {
                Text(profile.name)
                    .font(.system(size: 38, weight: .semibold))
                    .minimumScaleFactor(0.75)
                Text("\(profile.tier) - Member since \(profile.memberSince)")
                    .font(.system(size: 17))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
            }

            HStack(spacing: 18) {
                StatBox(icon: "flame", value: "\(profile.streak)", label: "Day Streak")
                StatBox(icon: "calendar", value: "\(profile.sessions)", label: "Sessions")
                StatBox(icon: "timer", value: "\(profile.practicedHours)h", label: "Practiced")
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(YogaFlowTheme.mintSoft.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private func accountInfo(_ profile: UserProfile) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Account Information")
                    .font(.system(size: 28, weight: .semibold))
                Spacer()
                Button("Edit") {}
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(YogaFlowTheme.brandDeep)
            }

            VStack(spacing: 0) {
                InfoRow(label: "Email Address", value: profile.email)
                Divider()
                InfoRow(label: "Focus Area", value: profile.focusArea)
                Divider()
                InfoRow(label: "Experience Level", value: profile.level)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(YogaFlowTheme.border))
            .shadow(color: .black.opacity(0.03), radius: 10, y: 4)
        }
    }

    private var practiceHistory: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Practice History")
                    .font(.system(size: 28, weight: .semibold))
                Spacer()
                Button("View All  ›") {}
                    .font(.system(size: 14))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
            }

            VStack(spacing: 14) {
                ForEach(viewModel.history) { item in
                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(YogaFlowTheme.mintSoft)
                            .frame(width: 52, height: 52)
                            .overlay(Image(systemName: item.icon).foregroundStyle(YogaFlowTheme.brandDeep))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.system(size: 17, weight: .medium))
                            Text(item.metadata)
                                .font(.system(size: 13))
                                .foregroundStyle(YogaFlowTheme.textSecondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(YogaFlowTheme.textSecondary)
                    }
                    .padding(18)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(YogaFlowTheme.border))
                }
            }
        }
    }

    private var notifications: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Notifications")
                .font(.system(size: 28, weight: .semibold))

            VStack(spacing: 0) {
                ToggleRow(icon: "bell", title: "Practice Reminders", isOn: $viewModel.remindersEnabled)
                Divider()
                ToggleRow(icon: "arrow.up.right", title: "Goal Achievements", isOn: $viewModel.achievementsEnabled)
                Divider()
                ToggleRow(icon: "envelope", title: "Newsletter & Tips", isOn: $viewModel.newsletterEnabled)
            }
            .padding(.vertical, 6)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(YogaFlowTheme.border))
            .shadow(color: .black.opacity(0.03), radius: 10, y: 4)
        }
    }

    private var logoutButton: some View {
        Button("Log Out") {}
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(YogaFlowTheme.destructive)
            .frame(maxWidth: .infinity)
            .frame(height: 62)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(YogaFlowTheme.destructive.opacity(0.25)))
    }
}

private struct StatBox: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(YogaFlowTheme.brand)
            Text(value)
                .font(.system(size: 22, weight: .semibold))
            Text(label)
                .font(.system(size: 14))
                .foregroundStyle(YogaFlowTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 112)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(YogaFlowTheme.border))
        .shadow(color: .black.opacity(0.04), radius: 8, y: 4)
    }
}

private struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .tracking(1.3)
                .foregroundStyle(YogaFlowTheme.textTertiary)
            Text(value)
                .font(.system(size: 16))
                .foregroundStyle(YogaFlowTheme.ink)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
    }
}

private struct ToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
                    .frame(width: 26)
                Text(title)
                    .font(.system(size: 16))
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: YogaFlowTheme.brand))
        .padding(.horizontal, 18)
        .frame(height: 58)
    }
}
