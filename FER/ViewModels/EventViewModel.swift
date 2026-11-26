//
//  EventViewModel.swift
//  FER
//
//  Created by SOFIA VERDUGO on 24/11/26.
//

import Foundation
import Observation

@Observable
class EventViewModel {
    var events: [Event] = []
    init() {
        loadEvents()
    }
    func loadEvents() {
        events = [
            Event(
                id: 1,
                title: "Evento Increible para becados",
                description: "Los invitamos al primer Encuentro Comunidad FER Talento Sonorense ⭐️ \n Este es un evento exclusivo para becarios de nivel preparatoria y universidad. Acompáñanos y confirma tu asistencia para ser parte de este encuentro. 🙌 ",
                location: "Teatro COBACH",
                address: "COBACH Villa de Seris, Hermosillo",
                dateTime: Calendar.current.date(
                    from: DateComponents(year: 2026, month: 11, day: 25, hour: 14, minute: 30)
                    )!,
                endDateTime: Calendar.current.date(
                    from: DateComponents(year: 2026, month: 11, day: 25, hour: 16, minute: 00)
                    )!,
                cost: "Gratis",
                registerLink: "example.com",
                photo: "fer1",
                createdAt: Date(),
                updatedAt: Date(),
                audiences: ["Becados", "Aspirantes", "Otros"],
                levels: ["Preparatoria", "Universidad", "Maestría"]
            )
        ]
    }
}
