import SwiftUI

struct BrandHeader: View {
    let title: String
    var showsBack = false
    var trailing: String?
    var onBack: (() -> Void)?
    var onTrailing: (() -> Void)?

    var body: some View {
        HStack {
            Button {
                onBack?()
            } label: {
                Image(systemName: showsBack ? "arrow.left" : "line.3.horizontal")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(showsBack ? YogaFlowTheme.brand : YogaFlowTheme.ink)
            }
            .opacity(showsBack || title != "YogaFlow" ? 1 : 0)

            Spacer()

            Text(title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(YogaFlowTheme.ink)

            Spacer()

            if let trailing {
                Button(trailing) {
                    onTrailing?()
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(trailing == "SKIP" ? YogaFlowTheme.brand : YogaFlowTheme.ink)
            } else {
                Circle()
                    .fill(YogaFlowTheme.mintSoft)
                    .frame(width: 30, height: 30)
                    .overlay(Image(systemName: "person.fill").font(.caption))
            }
        }
        .padding(.horizontal, 24)
        .frame(height: 64)
        .background(.white)
    }
}

struct PrimaryButton: View {
    let title: String
    var icon: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(title)
                if let icon {
                    Image(systemName: icon)
                }
            }
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(YogaFlowTheme.onPrimaryText)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(YogaFlowTheme.brand)
            .clipShape(Capsule())
            .shadow(color: YogaFlowTheme.brand.opacity(0.24), radius: 16, y: 8)
        }
        .buttonStyle(.plain)
    }
}

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(YogaFlowTheme.ink)
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(.white)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(YogaFlowTheme.border, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}

struct ProgressLine: View {
    let progress: Double

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.black.opacity(0.08))
                Capsule()
                    .fill(YogaFlowTheme.brand)
                    .frame(width: proxy.size.width * progress)
            }
        }
        .frame(height: 5)
    }
}

struct SelectionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let selected: Bool

    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 22)
                .fill(selected ? .white : YogaFlowTheme.mintSoft.opacity(0.75))
                .frame(width: 70, height: 70)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(YogaFlowTheme.brandDeep)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(YogaFlowTheme.ink)
                    .minimumScaleFactor(0.8)
                Text(subtitle)
                    .font(.system(size: 18))
                    .foregroundStyle(YogaFlowTheme.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            if selected {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(YogaFlowTheme.brandDeep)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, minHeight: 118)
        .background(selected ? YogaFlowTheme.mintSurface : .white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(selected ? YogaFlowTheme.brand : YogaFlowTheme.border, lineWidth: selected ? 2 : 1)
        )
    }
}

struct SessionArtwork: View {
    let kind: SessionImageKind
    var height: CGFloat = 220

    var body: some View {
        ZStack {
            LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)

            Circle()
                .fill(.white.opacity(0.24))
                .frame(width: height * 0.8)
                .offset(x: height * 0.35, y: -height * 0.25)

            Image(systemName: symbol)
                .font(.system(size: height * 0.32, weight: .regular))
                .foregroundStyle(.white.opacity(0.9))
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var symbol: String {
        switch kind {
        case .mountain: "mountain.2"
        case .studio: "figure.yoga"
        case .sideBend: "figure.flexibility"
        case .strength: "figure.strengthtraining.traditional"
        case .warrior: "figure.mind.and.body"
        }
    }

    private var colors: [Color] {
        switch kind {
        case .mountain: [Color(hex: "123B46"), Color(hex: "F7A94C"), Color(hex: "0E2230")]
        case .studio: [Color(hex: "E8F5EB"), Color(hex: "B8D8C7"), Color(hex: "506B58")]
        case .sideBend: [Color(hex: "EAF2EE"), Color(hex: "7BA38F")]
        case .strength: [Color(hex: "2E130B"), Color(hex: "D7864A")]
        case .warrior: [Color(hex: "0F2428"), Color(hex: "5C8F9D")]
        }
    }
}

struct ReferenceImage: View {
    let name: String
    var height: CGFloat
    var cornerRadius: CGFloat = 16

    var body: some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension YogaFlowTheme {
    static let onPrimaryText = Color(hex: "003B28")
}
