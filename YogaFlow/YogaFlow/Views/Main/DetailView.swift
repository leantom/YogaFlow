import SwiftUI

struct DetailView: View {
    let viewModel: DetailViewModel
    let coordinator: AppCoordinator

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    coordinator.closeDetail()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(YogaFlowTheme.ink)
                }
                Text("YogaFlow")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Circle()
                    .fill(YogaFlowTheme.mintSoft)
                    .frame(width: 28, height: 28)
                    .overlay(Image(systemName: "person.fill").font(.caption2))
            }
            .padding(.horizontal, 18)
            .frame(height: 52)
            .background(.white)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    hero
                    metrics
                    about
                    expect
                    actionCard
                    zenTip
                    quote
                }
                .padding(.bottom, 40)
            }
            .background(YogaFlowTheme.mintBackground)
        }
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            ReferenceImage(name: "DetailStudio", height: 228, cornerRadius: 0)
                .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 18, bottomTrailingRadius: 18))
            Text("Vitality\nVinyasa")
                .font(.system(size: 38, weight: .semibold))
                .foregroundStyle(.white)
                .padding(24)
        }
    }

    private var metrics: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            DetailMetric(icon: "clock", label: "Duration", value: "\(viewModel.session.duration) min")
            DetailMetric(icon: "chart.bar", label: "Level", value: viewModel.session.level)
            DetailMetric(icon: "flame", label: "Intensity", value: viewModel.session.intensity)
        }
        .padding(.horizontal, 22)
    }

    private var about: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("About this Session")
                .font(.system(size: 24, weight: .semibold))
            Text(viewModel.session.description)
                .font(.system(size: 16))
                .lineSpacing(6)
                .foregroundStyle(YogaFlowTheme.textSecondary)
        }
        .padding(.horizontal, 22)
    }

    private var expect: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What to Expect")
                .font(.system(size: 24, weight: .semibold))
            VStack(spacing: 14) {
                DetailExpectation(icon: "wind", title: "Pranayama Focus", subtitle: "Rhythmic breathing techniques to energize the nervous system.")
                DetailExpectation(icon: "infinity", title: "Fluid Transitions", subtitle: "Seamless movement between poses for a meditative state.")
                DetailExpectation(icon: "bolt", title: "Core Stability", subtitle: "Targeted movements to strengthen the deep abdominal wall.")
                DetailExpectation(icon: "figure.cooldown", title: "Final Savasana", subtitle: "5-minute guided deep relaxation to seal your practice.")
            }
        }
        .padding(.horizontal, 22)
    }

    private var actionCard: some View {
        VStack(spacing: 20) {
            Button {
            } label: {
                Label("Start Practice", systemImage: "play.circle")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(YogaFlowTheme.ink)
                    .clipShape(Capsule())
            }

            SecondaryButton(title: "Save to Library") {}

            Divider().padding(.vertical, 4)

            VStack(alignment: .leading, spacing: 12) {
                Text("Instructor")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundStyle(YogaFlowTheme.textTertiary)
                HStack(spacing: 12) {
                    Circle()
                        .fill(LinearGradient(colors: [YogaFlowTheme.mintSoft, YogaFlowTheme.brand], startPoint: .top, endPoint: .bottom))
                        .frame(width: 54, height: 54)
                        .overlay(Image(systemName: "person.fill").font(.title3))
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Elena Rossi")
                            .font(.system(size: 17, weight: .semibold))
                        Text("Vinyasa & Hatha Specialist")
                            .font(.system(size: 13))
                            .foregroundStyle(YogaFlowTheme.textSecondary)
                        Text("View Profile")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(YogaFlowTheme.brandDeep)
                    }
                }

                Text("\"My goal is to help you find that sweet spot between effort and ease in every breath.\"")
                    .font(.system(size: 14))
                    .italic()
                    .foregroundStyle(YogaFlowTheme.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider().padding(.vertical, 4)

            VStack(alignment: .leading, spacing: 10) {
                Text("Equipment Needed")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundStyle(YogaFlowTheme.textTertiary)
                FlowLayout(items: ["Yoga Mat", "Yoga Blocks (Optional)", "Strap"])
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(26)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .overlay(RoundedRectangle(cornerRadius: 26).stroke(YogaFlowTheme.border))
        .padding(.horizontal, 22)
    }

    private var zenTip: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: "sparkles")
                .foregroundStyle(YogaFlowTheme.brandDeep)
            VStack(alignment: .leading, spacing: 8) {
                Text("Zen Tip")
                    .font(.system(size: 16, weight: .semibold))
                Text("Try to keep your gaze fixed on one point to improve stability and focus.")
                    .font(.system(size: 14))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
            }
        }
        .padding(22)
        .background(YogaFlowTheme.mintSoft.opacity(0.45))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(YogaFlowTheme.border))
        .padding(.horizontal, 22)
    }

    private var quote: some View {
        VStack(spacing: 22) {
            Text("”")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(YogaFlowTheme.brandDeep)
            Text("The practice of\nyoga is about\nthe journey, not\nthe destination.")
                .font(.system(size: 31, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(YogaFlowTheme.ink)
            Text("Whether you're just starting out or looking to deepen your existing practice, we're here to flow with you every step of the way.")
                .font(.system(size: 14))
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .foregroundStyle(YogaFlowTheme.textSecondary)
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 54)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 34))
    }
}

private struct DetailMetric: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(YogaFlowTheme.brandDeep)
                .frame(width: 34, height: 34)
                .background(YogaFlowTheme.mintSoft)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 3) {
                Text(label)
                    .font(.system(size: 12))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
                Text(value)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(YogaFlowTheme.ink)
            }
        }
    }
}

private struct DetailExpectation: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(YogaFlowTheme.brandDeep)
                .frame(width: 42)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
            }
            Spacer()
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(YogaFlowTheme.border))
    }
}

private struct FlowLayout: View {
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(YogaFlowTheme.brandDeep)
                    .padding(.horizontal, 8)
                    .frame(height: 24)
                    .background(YogaFlowTheme.mintSoft)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
    }
}
