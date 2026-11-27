import SwiftUI

enum WelcomeColors {
    static let bgTop = rgb(0x3A6AC0)
    static let bgMid = rgb(0x1B3FA8)
    static let bgBottom = rgb(0x1238BA)
    static let bgGlow = rgb(0x4A82B8)
    static let navyText = rgb(0x1E2C7C)
    static let buttonText = rgb(0x1B3CA8)
    static let subtitle = rgb(0xD5DCF5)
    static let squiggleTeal = rgb(0x5DBABB)
    static let squiggleBlue = rgb(0x2F70DF)

    private static func rgb(_ hex: UInt) -> Color {
        Color(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

enum WelcomeFonts {
    static func poppins(_ size: CGFloat, medium: Bool = true) -> Font {
        .custom(medium ? "Poppins-Medium" : "Poppins-Regular", size: size)
    }

    static func cormorant(_ size: CGFloat) -> Font {
        .custom("CormorantSC-Medium", size: size)
    }
}

struct WelcomeBackground: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    stops: [
                        .init(color: WelcomeColors.bgTop, location: 0),
                        .init(color: WelcomeColors.bgMid, location: 0.45),
                        .init(color: WelcomeColors.bgBottom, location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                RadialGradient(
                    colors: [WelcomeColors.bgGlow, WelcomeColors.bgGlow.opacity(0)],
                    center: UnitPoint(x: 0.95, y: 0.02),
                    startRadius: 0,
                    endRadius: geo.size.width * 0.9
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview { WelcomeBackground() }
