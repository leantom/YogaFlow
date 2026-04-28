import SwiftUI

struct PlanSummaryView: View {
    @State var viewModel: PlanSummaryViewModel
    let coordinator: AppCoordinator

    var body: some View {
        VStack(spacing: 0) {
            BrandHeader(title: "YogaFlow", showsBack: true, trailing: "SKIP", onBack: {
                coordinator.showLevelStep()
            }, onTrailing: {
                coordinator.showMain()
            })

            ProgressLine(progress: 1)

            ScrollView(showsIndicators: false) {
                if let plan = viewModel.plan {
                    VStack(spacing: 30) {
                        VStack(spacing: 16) {
                            Text("You're all set, \(plan.userName)!")
                                .font(.system(size: 42, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(YogaFlowTheme.ink)
                            Text("Your personalized practice is ready.")
                                .font(.system(size: 22))
                                .foregroundStyle(YogaFlowTheme.textSecondary)
                        }
                        .padding(.top, 48)

                        VStack(spacing: 0) {
                            ReferenceImage(name: "PlanYoga", height: 300, cornerRadius: 0)
                                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, topTrailingRadius: 30))

                            VStack(spacing: 16) {
                                SummaryRow(icon: "target", label: "GOAL", value: plan.goal.title)
                                SummaryRow(icon: "chart.bar", label: "LEVEL", value: plan.level.title)
                            }
                            .padding(28)
                            .background(.white)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(YogaFlowTheme.border))
                        .padding(.horizontal, 34)

                        HStack(spacing: 14) {
                            PillLabel(icon: "calendar", text: "\(plan.dailyMinutes) min / day")
                            PillLabel(icon: "leaf", text: plan.style)
                        }

                        VStack(spacing: 18) {
                            PrimaryButton(title: "Go to My Dashboard") {
                                coordinator.showMain(tab: .home)
                            }
                            SecondaryButton(title: "Review my plan") {}
                        }
                        .padding(.horizontal, 34)
                        .padding(.bottom, 36)
                    }
                }
            }
            .background(Color.white)
        }
        .task { await viewModel.load() }
    }
}

private struct SummaryRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(YogaFlowTheme.brandDeep)
                .frame(width: 42)
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
                Text(value)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(YogaFlowTheme.ink)
            }
            Spacer()
            Image(systemName: "checkmark.circle")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(YogaFlowTheme.brandDeep)
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(YogaFlowTheme.border))
    }
}

private struct PillLabel: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 18, weight: .medium))
        .foregroundStyle(YogaFlowTheme.textSecondary)
        .padding(.horizontal, 20)
        .frame(height: 46)
        .background(YogaFlowTheme.mintSoft.opacity(0.8))
        .clipShape(Capsule())
    }
}
