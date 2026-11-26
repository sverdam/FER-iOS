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

    static let catalogo: [FAQItem] = [
        FAQItem(
            id: 1,
            question: "¿Qué niveles educativos cuentan con becas?",
            answer: "Respuesta de ejemplo para los niveles educativos con beca.",
            category: .aspirantes
        ),
        FAQItem(
            id: 2,
            question: "¿Cómo puedo solicitar una beca?",
            answer: "Para solicitar una beca debes registrarte en la plataforma, completar el formulario y adjuntar los documentos requeridos.",
            category: .becarios
        ),
        FAQItem(
            id: 3,
            question: "¿Cuáles son los requisitos para ser becario?",
            answer: "Los requisitos principales son promedio mínimo, estar inscrito en una institución educativa y no tener otra beca vigente.",
            category: .becarios
        ),
        FAQItem(
            id: 4,
            question: "¿Hasta cuándo puedo aplicar?",
            answer: "Las convocatorias suelen cerrar a finales de cada semestre. Revisa las fechas en la sección de convocatorias.",
            category: .aspirantes
        ),
        FAQItem(
            id: 5,
            question: "¿Puedo tener más de una beca al mismo tiempo?",
            answer: "No, solo se permite una beca vigente por persona. Debes renunciar a la anterior si quieres aplicar a una nueva.",
            category: .becarios
        ),
        FAQItem(
            id: 6,
            question: "¿Qué documentos necesito para el registro?",
            answer: "Identificación oficial, comprobante de domicilio, constancia de estudios y promedio actualizado.",
            category: .aspirantes
        ),
        FAQItem(
            id: 7,
            question: "¿Cómo puedo dar seguimiento a mi solicitud?",
            answer: "Puedes revisar el estado de tu solicitud iniciando sesión con tu correo y contraseña en la sección de Mi Cuenta.",
            category: .becarios
        )
    ]
}
