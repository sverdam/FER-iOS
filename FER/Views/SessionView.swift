import SwiftUI

// Screen 3: Session started
struct SessionView: View {
    let audience: String
    let level: String
    let onChangeProfile: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            FoundationLogo().padding(.top, 40)
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.white)
                .padding(.bottom, 20)

            Text("¡Sesión iniciada!")
                .font(WelcomeTheme.font(40, .medium))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.7)
                .lineLimit(1)

            Text("Tu experiencia ya está personalizada.")
                .font(WelcomeTheme.font(18))
                .foregroundStyle(WelcomeTheme.subtitle)
                .multilineTextAlignment(.center)
                .padding(.top, 4)

            VStack(spacing: 10) {
                DataRow(title: "Perfil", value: audience)
                DataRow(title: "Nivel", value: level)
            }
            .padding(.horizontal, 40)
            .padding(.top, 36)

            Spacer()

            Button(action: onChangeProfile) {
                Text("Cambiar perfil")
                    .font(WelcomeTheme.font(18, .medium))
                    .foregroundStyle(.white.opacity(0.85))
                    .underline()
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    ZStack {
        GradientBackground()
        SessionView(audience: "Becario", level: "Universidad") {}
    }
}
