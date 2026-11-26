import SwiftUI

struct RootView: View {
    // Stored in UserDefaults. If both exist, skip straight to the session.
    @AppStorage("savedAudience") private var savedAudience = ""
    @AppStorage("savedLevel") private var savedLevel = ""

    @State private var step: Step
    @State private var selectedAudience: Audience?
    @State private var selectedLevel: Level?

    init() {
        let defaults = UserDefaults.standard
        let hasAudience = Audience(rawValue: defaults.string(forKey: "savedAudience") ?? "") != nil
        let hasLevel = Level(rawValue: defaults.string(forKey: "savedLevel") ?? "") != nil
        _step = State(initialValue: (hasAudience && hasLevel) ? .session : .audience)
    }

    var body: some View {
        ZStack {
            GradientBackground()

            switch step {
            case .audience:
                AudienceView(selection: $selectedAudience) {
                    changeStep(to: .level)
                }
                .transition(.asymmetric(
                    insertion: .opacity,
                    removal: .move(edge: .leading).combined(with: .opacity)))

            case .level:
                LevelView(selection: $selectedLevel) {
                    guard let audience = selectedAudience, let level = selectedLevel else { return }
                    savedAudience = audience.rawValue
                    savedLevel = level.rawValue
                    changeStep(to: .session)
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)))

            case .session:
                SessionView(audience: savedAudience, level: savedLevel) {
                    savedAudience = ""
                    savedLevel = ""
                    selectedAudience = nil
                    selectedLevel = nil
                    changeStep(to: .audience)
                }
                .transition(.opacity)
            }
        }
        .preferredColorScheme(.dark)
    }

    private func changeStep(to newStep: Step) {
        withAnimation(.easeInOut(duration: 0.3)) { step = newStep }
    }
}

#Preview("Full flow") { RootView() }
