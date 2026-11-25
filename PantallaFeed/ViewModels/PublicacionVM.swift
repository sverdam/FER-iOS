//
//  PublicacionVM.swift
//  PantallaFeed
//
//  Created by MAC on 24/11/26.
//

import Foundation
import Observation

@Observable
class PublicacionesViewModel {
    var posts: [Publicacion] = []
    var isLoading = false
    var error: String?

    var likedPosts: [Publicacion] {
        posts.filter { $0.hasLiked }
    }

    init() {
        loadPosts()
    }

    func loadPosts() {
        let now = Date()
        let calendar = Calendar.current

        func daysAgo(_ days: Int) -> Date {
            calendar.date(byAdding: .day, value: -days, to: now) ?? now
        }

        posts = [
            Publicacion(id: 1,
                        title: "¡Renueva tu beca!",
                        description: "No olvides renovar tu beca. Ve reuniendo tus documentos y consulta los requisitos.",
                        body: "Si eres becario, ya puedes comenzar con tu proceso de renovación. Reúne tus documentos y revisa las fechas límite.",
                        thumbnail: "fer2",
                        authorId: 1,
                        createdAt: daysAgo(0)),
            Publicacion(id: 2,
                        title: "80 años creyendo en ti",
                        description: "Creer en un joven es invertir en el futuro de Sonora. Fundación Esposos Rodríguez celebra 80 años.",
                        body: "Fundación Esposos Rodríguez celebra 80 años de apoyar a jóvenes talentosos de Sonora.",
                        thumbnail: "fer3",
                        authorId: 1,
                        createdAt: daysAgo(1)),
            Publicacion(id: 3,
                        title: "Convocatoria de nuevo ingreso",
                        description: "Ya está abierta la convocatoria para aspirantes a una beca. Conoce los requisitos y fechas.",
                        body: "Si estás por iniciar tus estudios y buscas una beca, revisa los requisitos y regístrate antes de la fecha límite.",
                        thumbnail: "fer4",
                        authorId: 1,
                        createdAt: daysAgo(2)),
            Publicacion(id: 4,
                        title: "Taller para padres de familia",
                        description: "Acompañar a tu hijo en su trayectoria académica. Te esperamos en nuestro taller.",
                        body: "Invitamos a los padres de nuestros becarios a participar en un taller sobre cómo apoyar el desarrollo académico de sus hijos.",
                        thumbnail: "fer5",
                        authorId: 2,
                        createdAt: daysAgo(4),
                        likes: 1,
                        hasLiked: true),
            Publicacion(id: 5,
                        title: "Resultados de selección",
                        description: "Consulta si fuiste seleccionado en el proceso de este ciclo escolar.",
                        body: "Los resultados ya están disponibles. Revisa tu correo y el portal para conocer el estatus de tu solicitud.",
                        thumbnail: "fer6",
                        authorId: 1,
                        createdAt: daysAgo(6)),
            Publicacion(id: 6,
                        title: "Historias de éxito",
                        description: "Conoce a exbecarios que hoy están transformando Sonora con su trabajo.",
                        body: "Compartimos las historias de egresados que lograron sus metas gracias al apoyo de la fundación.",
                        thumbnail: "fer7",
                        authorId: 2,
                        createdAt: daysAgo(9))
        ]
    }

    func toggleLike(postId: Int) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else { return }
        posts[index].hasLiked.toggle()
        posts[index].likes = posts[index].hasLiked ? 1 : 0
    }
}
