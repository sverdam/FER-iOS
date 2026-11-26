import Foundation

enum Audience: String, CaseIterable, Identifiable {
    case applicant = "Aspirante"
    case scholar = "Becario"
    case other = "Otro"
    var id: String { rawValue }
}

enum Level: String, CaseIterable, Identifiable {
    case highSchool = "Preparatoria"
    case university = "Universidad"
    case postgraduate = "Posgrado"
    var id: String { rawValue }
}

enum Step {
    case audience, level, session
}
