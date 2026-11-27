import SwiftUI

enum AppearanceMode: String, CaseIterable, Identifiable {
    case light, dark, system

    var id: Self { self }

    var title: String {
        switch self {
        case .light:  return "Claro"
        case .dark:   return "Oscuro"
        case .system: return "Sistema"
        }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:  return .light
        case .dark:   return .dark
        case .system: return .unspecified
        }
    }
}

enum TextSizeOption: String, CaseIterable, Identifiable {
    case normal, large, extraLarge

    var id: Self { self }

    var title: String {
        switch self {
        case .normal:     return "Normal"
        case .large:      return "Grande"
        case .extraLarge: return "Muy Grande"
        }
    }

    var steps: Int {
        switch self {
        case .normal:     return 0
        case .large:      return 2
        case .extraLarge: return 3
        }
    }

    func applied(to base: DynamicTypeSize) -> DynamicTypeSize {
        let sizes = DynamicTypeSize.allCases
        guard let index = sizes.firstIndex(of: base) else { return base }
        return sizes[min(index + steps, sizes.count - 1)]
    }
}

struct AppInfo {
    let organization: String
    let version: String
    let phone: String
    let email: String
    let privacyNote: String

    static var current: AppInfo {
        AppInfo(
            organization: "Fundacion Esposos Rodriguez",
            version: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0",
            phone: "662 212 1453",
            email: "info@fer.org.mx",
            privacyNote: "Los datos de Sobre ti se quedan en este telefono"
        )
    }
}
