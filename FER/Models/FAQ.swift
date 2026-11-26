import Foundation

enum FAQCategoria: String, CaseIterable, Identifiable {
    case aspirantes = "Aspirantes"
    case becarios = "Becarios"

    var id: String { rawValue }
}

struct FAQItem: Identifiable {
    let id: Int
    let question: String
    let answer: String
    let category: FAQCategoria
}
