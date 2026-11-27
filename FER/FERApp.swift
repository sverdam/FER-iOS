import SwiftUI
import UIKit

@main
struct FERApp: App {
    var body: some Scene {
        WindowGroup {
            MainFeed()
                .modifier(AppearanceApplier())
        }
    }
}

private struct AppearanceApplier: ViewModifier {
    @AppStorage("appearance") private var appearance: AppearanceMode = .system

    func body(content: Self.Content) -> some View {
        content
            .onAppear { apply(appearance) }
            .onChange(of: appearance) { _, newValue in apply(newValue) }
    }

    private func apply(_ mode: AppearanceMode) {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .forEach { $0.overrideUserInterfaceStyle = mode.userInterfaceStyle }
    }
}
