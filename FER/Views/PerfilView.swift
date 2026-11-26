import SwiftUI

// Pantalla 1: ¿Cuál es tu perfil?
struct PerfilView: View {
    @Binding var seleccion: Perfil?
    let continuar: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            LogoFundacion().padding(.top, 40)
            Spacer()
            EncabezadoBienvenida()
            Text("¿Cuál es tu perfil?")
                .font(Tema.fuente(20))
                .foregroundStyle(.white)
                .padding(.top, 50)
                .padding(.bottom, 14)
            VStack(spacing: 14) {
                ForEach(Perfil.allCases) { p in
                    BotonOpcion(titulo: p.rawValue, seleccionado: seleccion == p) {
                        seleccion = p
                    }
                }
            }
            .padding(.horizontal, 40)
            BotonContinuar(titulo: "Continuar", habilitado: seleccion != nil, accion: continuar)
                .padding(.top, 50)
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var seleccion: Perfil? = nil
    ZStack {
        FondoAzul()
        PerfilView(seleccion: $seleccion) {}
    }
}
