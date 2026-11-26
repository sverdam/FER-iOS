import SwiftUI

// Colors and typography taken from the design screenshots
enum WelcomeTheme {
    static let topBlue   = Color(red: 0.17, green: 0.33, blue: 0.56)   // ~#2B5590
    static let indigo    = Color(red: 0.22, green: 0.22, blue: 0.62)   // ~#38389E
    static let lightBlue = Color(red: 0.27, green: 0.37, blue: 0.70)   // ~#455EB3
    static let textBlue  = Color(red: 0.12, green: 0.15, blue: 0.50)   // button text
    static let subtitle  = Color.white.opacity(0.7)

    static func font(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        // Uses Montserrat if added to the project; otherwise falls back to the system font.
        .custom("Montserrat-Regular", size: size).weight(weight)
    }
}

struct GradientBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [WelcomeTheme.topBlue, WelcomeTheme.indigo, WelcomeTheme.topBlue.opacity(0.9)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            RadialGradient(
                colors: [WelcomeTheme.lightBlue.opacity(0.9), .clear],
                center: .init(x: 0.95, y: 0.45), startRadius: 0, endRadius: 320
            )
            RadialGradient(
                colors: [WelcomeTheme.indigo.opacity(0.8), .clear],
                center: .init(x: 0.2, y: 0.85), startRadius: 0, endRadius: 300
            )
        }
        .ignoresSafeArea()
    }
}

#Preview { GradientBackground() }
