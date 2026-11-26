import SwiftUI

// Pantalla 3: Sesión iniciada
struct SesionIniciadaView: View {
    let perfil: String
    let nivel: String
    let cerrarSesion: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            LogoFundacion().padding(.top, 40)
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.white)
                .padding(.bottom, 20)

            Text("¡Sesión iniciada!")
                .font(Tema.fuente(40, .medium))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.7)
                .lineLimit(1)

            Text("Tu experiencia ya está personalizada.")
                .font(Tema.fuente(18))
                .foregroundStyle(Tema.subtitulo)
                .multilineTextAlignment(.center)
                .padding(.top, 4)

            VStack(spacing: 10) {
                FilaDato(titulo: "Perfil", valor: perfil)
                FilaDato(titulo: "Nivel", valor: nivel)
            }
            .padding(.horizontal, 40)
            .padding(.top, 36)

            Spacer()

            Button(action: cerrarSesion) {
                Text("Cambiar perfil")
                    .font(Tema.fuente(18, .medium))
                    .foregroundStyle(.white.opacity(0.85))
                    .underline()
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    ZStack {
        FondoAzul()
        SesionIniciadaView(perfil: "Becario", nivel: "Universidad") {}
    }
}
