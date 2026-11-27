//
//  ScholarshipProfile.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

enum ScholarshipProfile: String, CaseIterable, Identifiable {
    case aspirante = "Aspirante"
    case becado = "Becado"
    case otros = "Otros"

    var id: Self { self }

    var slug: String {
        switch self {
        case .aspirante: return "aspirantes"
        case .becado: return "becados"
        case .otros: return "otros"
        }
    }
}
