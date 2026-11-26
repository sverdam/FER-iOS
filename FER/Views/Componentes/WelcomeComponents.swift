import SwiftUI

struct FoundationLogo: View {
    var body: some View {
        // Add your logo to Assets with the name "logo_fundacion".
        if UIImage(named: "logo_fundacion") != nil {
            Image("logo_fundacion")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
        } else {
            // Text fallback while the logo isn't in Assets yet.
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

struct WelcomeHeader: View {
    var body: some View {
        VStack(spacing: 2) {
            Text("¡Bienvenido!")
                .font(WelcomeTheme.font(52, .medium))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
            Text("Personaliza tu experiencia.")
                .font(WelcomeTheme.font(20))
                .foregroundStyle(WelcomeTheme.subtitle)
        }
    }
}

struct OptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Text(title)
                    .font(WelcomeTheme.font(22, .medium))
                    .foregroundStyle(WelcomeTheme.textBlue)
                if isSelected {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(WelcomeTheme.lightBlue)
                            .padding(.trailing, 16)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Capsule().fill(.white))
            .overlay(
                Capsule().stroke(WelcomeTheme.lightBlue, lineWidth: isSelected ? 3 : 0)
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

struct ContinueButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                Image(systemName: "arrow.right")
            }
            .font(WelcomeTheme.font(20, .medium))
            .foregroundStyle(.white.opacity(0.85))
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.4)
        .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
}

struct DataRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title).foregroundStyle(WelcomeTheme.textBlue.opacity(0.6))
            Spacer()
            Text(value).foregroundStyle(WelcomeTheme.textBlue).fontWeight(.semibold)
        }
        .font(WelcomeTheme.font(20))
        .padding(.horizontal, 24)
        .frame(height: 50)
        .background(Capsule().fill(.white))
    }
}
