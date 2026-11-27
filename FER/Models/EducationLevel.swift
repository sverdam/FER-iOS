//
//  EducationLevel.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

enum EducationLevel: String, CaseIterable, Identifiable {
    case preparatoria = "Preparatoria"
    case universidad = "Universidad"
    case posgrado = "Posgrado"

    var id: Self { self }

    var slug: String {
        switch self {
        case .preparatoria: return "prepa"
        case .universidad: return "uni"
        case .posgrado: return "posgrado"
        }
    }
}
