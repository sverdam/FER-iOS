import SwiftUI

enum AppTheme {
    // Brand
    static let accentBlue = Color(red: 0.12, green: 0.25, blue: 0.58)
    static let destructiveText = Color(red: 0.78, green: 0.16, blue: 0.16)

    // Backgrounds
    static let background = Color.dynamic(
        light: Color(red: 0.97, green: 0.97, blue: 0.98),
        dark:  Color(red: 0.06, green: 0.07, blue: 0.11)
    )
    static let surface = Color.dynamic(
        light: .white,
        dark:  Color(red: 0.11, green: 0.12, blue: 0.18)
    )

    // Text
    static let textPrimary = Color.dynamic(
        light: Color(red: 0.08, green: 0.09, blue: 0.14),
        dark:  .white
    )
    static let textSecondary = Color.dynamic(
        light: Color(red: 0.08, green: 0.09, blue: 0.14).opacity(0.6),
        dark:  Color.white.opacity(0.7)
    )

    // Lines and separators
    static let border = Color.dynamic(
        light: Color.black.opacity(0.1),
        dark:  Color.white.opacity(0.15)
    )
}


extension Color {
    static func dynamic(light: Color, dark: Color) -> Color {
        Color(UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}

