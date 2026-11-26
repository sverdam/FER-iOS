import SwiftUI


struct RootView: View {
    // Se guardan en UserDefaults. Si ya existen, se salta directo a la sesión.
    @AppStorage("perfilGuardado") private var perfilGuardado = ""
    @AppStorage("nivelGuardado") private var nivelGuardado = ""

    @State private var paso: Paso
    @State private var perfilSel: Perfil?
    @State private var nivelSel: Nivel?

    init() {
        let d = UserDefaults.standard
        let hayPerfil = Perfil(rawValue: d.string(forKey: "perfilGuardado") ?? "") != nil
        let hayNivel = Nivel(rawValue: d.string(forKey: "nivelGuardado") ?? "") != nil
        _paso = State(initialValue: (hayPerfil && hayNivel) ? .sesion : .perfil)
    }

    var body: some View {
        ZStack {
            FondoAzul()

            switch paso {
            case .perfil:
                PerfilView(seleccion: $perfilSel) {
                    cambiar(a: .nivel)
                }
                .transition(.asymmetric(
                    insertion: .opacity,
                    removal: .move(edge: .leading).combined(with: .opacity)))

            case .nivel:
                NivelView(seleccion: $nivelSel) {
                    guard let p = perfilSel, let n = nivelSel else { return }
                    perfilGuardado = p.rawValue
                    nivelGuardado = n.rawValue
                    cambiar(a: .sesion)
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)))

            case .sesion:
                SesionIniciadaView(perfil: perfilGuardado, nivel: nivelGuardado) {
                    perfilGuardado = ""
                    nivelGuardado = ""
                    perfilSel = nil
                    nivelSel = nil
                    cambiar(a: .perfil)
                }
                .transition(.opacity)
            }
        }
        .preferredColorScheme(.dark)
    }

    private func cambiar(a nuevo: Paso) {
        withAnimation(.easeInOut(duration: 0.3)) { paso = nuevo }
    }
}

#Preview("Flujo completo") { RootView() }
