import Foundation

enum Perfil: String, CaseIterable, Identifiable {
    case aspirante = "Aspirante"
    case becario = "Becario"
    case otro = "Otro"
    var id: String { rawValue }
}

enum Nivel: String, CaseIterable, Identifiable {
    case preparatoria = "Preparatoria"
    case universidad = "Universidad"
    case posgrado = "Posgrado"
    var id: String { rawValue }
}

enum Paso {
    case perfil, nivel, sesion
}
