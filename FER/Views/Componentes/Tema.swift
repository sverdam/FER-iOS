import SwiftUI

// Colores y tipografía sacados de las capturas
enum Tema {
    static let azulArriba = Color(red: 0.17, green: 0.33, blue: 0.56)   // ~#2B5590
    static let indigo     = Color(red: 0.22, green: 0.22, blue: 0.62)   // ~#38389E
    static let azulClaro  = Color(red: 0.27, green: 0.37, blue: 0.70)   // ~#455EB3
    static let azulTexto  = Color(red: 0.12, green: 0.15, blue: 0.50)   // texto de botones
    static let subtitulo  = Color.white.opacity(0.7)

    static func fuente(_ size: CGFloat, _ peso: Font.Weight = .regular) -> Font {
        // Si agregas Montserrat al proyecto se usa; si no, cae a la fuente del sistema.
        .custom("Montserrat-Regular", size: size).weight(peso)
    }
}

struct FondoAzul: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Tema.azulArriba, Tema.indigo, Tema.azulArriba.opacity(0.9)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            RadialGradient(
                colors: [Tema.azulClaro.opacity(0.9), .clear],
                center: .init(x: 0.95, y: 0.45), startRadius: 0, endRadius: 320
            )
            RadialGradient(
                colors: [Tema.indigo.opacity(0.8), .clear],
                center: .init(x: 0.2, y: 0.85), startRadius: 0, endRadius: 300
            )
        }
        .ignoresSafeArea()
    }
}

#Preview { FondoAzul() }
