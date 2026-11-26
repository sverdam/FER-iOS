import SwiftUI

// Screen 2: "What is your education level?"
struct LevelView: View {
    @Binding var selection: Level?
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            FoundationLogo().padding(.top, 40)
            Spacer()
            WelcomeHeader()
            Text("¿Cuál es tu nivel educativo?")
                .font(WelcomeTheme.font(20))
                .foregroundStyle(.white)
                .padding(.top, 50)
                .padding(.bottom, 14)
            VStack(spacing: 14) {
                ForEach(Level.allCases) { level in
                    OptionButton(title: level.rawValue, isSelected: selection == level) {
                        selection = level
                    }
                }
            }
            .padding(.horizontal, 40)
            Spacer()
            ContinueButton(title: "Continuar", isEnabled: selection != nil, action: onContinue)
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    @Previewable @State var selection: Level? = nil
    ZStack {
        GradientBackground()
        LevelView(selection: $selection) {}
    }
}
