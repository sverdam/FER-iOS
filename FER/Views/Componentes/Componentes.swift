import SwiftUI

struct LogoFundacion: View {
    var body: some View {
        // Agrega tu logo en Assets con el nombre "logo_fundacion".
        if UIImage(named: "logo_fundacion") != nil {
            Image("logo_fundacion")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
        } else {
            // Respaldo en texto mientras no tengas el logo en Assets.
            VStack(spacing: 6) {
                Rectangle().fill(.white.opacity(0.6)).frame(width: 100, height: 1)
                VStack(spacing: 0) {
                    Text("Fundación").font(.system(size: 30, weight: .regular, design: .serif))
                    Text("Esposos").font(.system(size: 38, weight: .regular, design: .serif))
                    Text("Rodríguez").font(.system(size: 38, weight: .regular, design: .serif))
                }
                .foregroundStyle(.white)
                Rectangle().fill(.white.opacity(0.6)).frame(width: 100, height: 1)
            }
        }
    }
}

struct EncabezadoBienvenida: View {
    var body: some View {
        VStack(spacing: 2) {
            Text("¡Bienvenido!")
                .font(Tema.fuente(52, .medium))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
            Text("Personaliza tu experiencia.")
                .font(Tema.fuente(20))
                .foregroundStyle(Tema.subtitulo)
        }
    }
}

struct BotonOpcion: View {
    let titulo: String
    let seleccionado: Bool
    let accion: () -> Void

    var body: some View {
        Button(action: accion) {
            ZStack {
                Text(titulo)
                    .font(Tema.fuente(22, .medium))
                    .foregroundStyle(Tema.azulTexto)
                if seleccionado {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Tema.azulClaro)
                            .padding(.trailing, 16)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Capsule().fill(.white))
            .overlay(
                Capsule().stroke(Tema.azulClaro, lineWidth: seleccionado ? 3 : 0)
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: seleccionado)
    }
}

struct BotonContinuar: View {
    let titulo: String
    let habilitado: Bool
    let accion: () -> Void

    var body: some View {
        Button(action: accion) {
            HStack(spacing: 10) {
                Text(titulo)
                Image(systemName: "arrow.right")
            }
            .font(Tema.fuente(20, .medium))
            .foregroundStyle(.white.opacity(0.85))
        }
        .disabled(!habilitado)
        .opacity(habilitado ? 1 : 0.4)
        .animation(.easeInOut(duration: 0.2), value: habilitado)
    }
}

struct FilaDato: View {
    let titulo: String
    let valor: String

    var body: some View {
        HStack {
            Text(titulo).foregroundStyle(Tema.azulTexto.opacity(0.6))
            Spacer()
            Text(valor).foregroundStyle(Tema.azulTexto).fontWeight(.semibold)
        }
        .font(Tema.fuente(20))
        .padding(.horizontal, 24)
        .frame(height: 50)
        .background(Capsule().fill(.white))
    }
}
