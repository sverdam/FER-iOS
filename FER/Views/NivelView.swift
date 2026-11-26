import SwiftUI

// Pantalla 2: ¿Cuál es tu nivel educativo?
struct NivelView: View {
    @Binding var seleccion: Nivel?
    let continuar: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            LogoFundacion().padding(.top, 40)
            Spacer()
            EncabezadoBienvenida()
            Text("¿Cuál es tu nivel educativo?")
                .font(Tema.fuente(20))
                .foregroundStyle(.white)
                .padding(.top, 50)
                .padding(.bottom, 14)
            VStack(spacing: 14) {
                ForEach(Nivel.allCases) { n in
                    BotonOpcion(titulo: n.rawValue, seleccionado: seleccion == n) {
                        seleccion = n
                    }
                }
            }
            .padding(.horizontal, 40)
            Spacer()
            BotonContinuar(titulo: "Continuar", habilitado: seleccion != nil, accion: continuar)
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    @Previewable @State var seleccion: Nivel? = nil
    ZStack {
        FondoAzul()
        NivelView(seleccion: $seleccion) {}
    }
}
