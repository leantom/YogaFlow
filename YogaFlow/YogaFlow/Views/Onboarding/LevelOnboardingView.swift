import SwiftUI

struct LevelOnboardingView: View {
    @State var viewModel: OnboardingViewModel
    let coordinator: AppCoordinator

    var body: some View {
        VStack(spacing: 0) {
            BrandHeader(title: "YogaFlow", showsBack: true, trailing: "SKIP", onBack: {
                coordinator.startOnboarding()
            }, onTrailing: {
                coordinator.showMain()
            })

            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    ProgressLine(progress: 2.0 / 3.0)
                        .padding(.horizontal, 34)
                        .padding(.top, 66)

                    VStack(spacing: 22) {
                        Text("How experienced are\nyou?")
                            .font(.system(size: 42, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(YogaFlowTheme.ink)

                        Text("We'll tailor your yoga journey to match your current comfort level and goals.")
                            .font(.system(size: 23))
                            .lineSpacing(9)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(YogaFlowTheme.textSecondary)
                    }
                    .padding(.horizontal, 36)

                    VStack(spacing: 24) {
                        ForEach(viewModel.levels) { level in
                            Button {
                                viewModel.selectedLevelID = level.id
                            } label: {
                                SelectionCard(
                                    icon: level.icon,
                                    title: level.title,
                                    subtitle: level.subtitle,
                                    selected: level.id == viewModel.selectedLevelID
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 34)

                    VStack(spacing: 18) {
                        PrimaryButton(title: "Continue") {
                            coordinator.showPlanSummary()
                        }
                        SecondaryButton(title: "Back") {
                            coordinator.startOnboarding()
                        }
                    }
                    .padding(.horizontal, 34)
                    .padding(.bottom, 36)
                }
            }
            .background(BackgroundWash())
        }
        .task { await viewModel.loadLevels() }
    }
}
