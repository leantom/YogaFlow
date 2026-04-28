import SwiftUI

struct ContentView: View {
    @State private var coordinator = AppLaunchScreen.coordinator(repository: YogaRepositoryFactory.makeMockRepository())

    var body: some View {
        RootCoordinatorView(coordinator: coordinator)
    }
}

#Preview {
    ContentView()
}
