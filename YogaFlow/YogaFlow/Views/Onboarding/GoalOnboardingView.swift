import SwiftUI

struct GoalOnboardingView: View {
    @State var viewModel: OnboardingViewModel
    let coordinator: AppCoordinator

    var body: some View {
        VStack(spacing: 0) {
            BrandHeader(title: "YogaFlow", showsBack: true, trailing: "SKIP", onBack: {
                coordinator.route = .splash
            }, onTrailing: {
                coordinator.showMain()
            })

            ProgressLine(progress: 1.0 / 3.0)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    VStack(spacing: 18) {
                        Text("STEP 1 OF 3")
                            .font(.system(size: 16, weight: .semibold))
                            .tracking(3)
                            .foregroundStyle(YogaFlowTheme.brandDeep)

                        Text("What brings you to\nthe mat?")
                            .font(.system(size: 40, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(YogaFlowTheme.ink)

                        Text("Select your primary goal to help us personalize your yoga journey for a mindful practice.")
                            .font(.system(size: 22))
                            .lineSpacing(8)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(YogaFlowTheme.textSecondary)
                    }
                    .padding(.top, 70)
                    .padding(.horizontal, 28)

                    VStack(spacing: 24) {
                        ForEach(viewModel.goals) { goal in
                            Button {
                                viewModel.selectedGoalID = goal.id
                            } label: {
                                SelectionCard(
                                    icon: goal.icon,
                                    title: goal.title,
                                    subtitle: goal.subtitle,
                                    selected: goal.id == viewModel.selectedGoalID
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 32)

                    VStack(spacing: 18) {
                        PrimaryButton(title: "Continue", icon: "arrow.right") {
                            coordinator.showLevelStep()
                        }

                        Text("You can always change your focus later in settings.")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(YogaFlowTheme.textSecondary)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 36)
                }
            }
            .background(BackgroundWash())
        }
        .task { await viewModel.loadGoals() }
    }
}

struct BackgroundWash: View {
    var body: some View {
        ZStack {
            Color.white
            Circle()
                .fill(YogaFlowTheme.brand.opacity(0.08))
                .blur(radius: 70)
                .offset(x: -150, y: -360)
            Circle()
                .fill(YogaFlowTheme.brand.opacity(0.10))
                .blur(radius: 90)
                .offset(x: 160, y: 360)
        }
    }
}
