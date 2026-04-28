import SwiftUI

struct SplashView: View {
    let viewModel: SplashViewModel
    let coordinator: AppCoordinator

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("SplashLake")
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    Button {
                        coordinator.startOnboarding()
                    } label: {
                        Color.clear
                            .frame(height: 72)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Start My Journey")
                    .padding(.horizontal, 34)
                    .padding(.bottom, 26)

                    Button {
                        coordinator.showMain(tab: .home)
                    } label: {
                        Color.clear
                            .frame(height: 38)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Sign In")
                    .padding(.horizontal, 90)
                    .padding(.bottom, 54)
                }
            }
        }
        .statusBarHidden(true)
    }
}
