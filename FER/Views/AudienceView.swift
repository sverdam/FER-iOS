import SwiftUI

// Screen 1: "What is your profile?"
struct AudienceView: View {
    @Binding var selection: Audience?
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            FoundationLogo().padding(.top, 40)
            Spacer()
            WelcomeHeader()
            Text("¿Cuál es tu perfil?")
                .font(WelcomeTheme.font(20))
                .foregroundStyle(.white)
                .padding(.top, 50)
                .padding(.bottom, 14)
            VStack(spacing: 14) {
                ForEach(Audience.allCases) { audience in
                    OptionButton(title: audience.rawValue, isSelected: selection == audience) {
                        selection = audience
                    }
                }
            }
            .padding(.horizontal, 40)
            ContinueButton(title: "Continuar", isEnabled: selection != nil, action: onContinue)
                .padding(.top, 50)
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var selection: Audience? = nil
    ZStack {
        GradientBackground()
        AudienceView(selection: $selection) {}
    }
}
