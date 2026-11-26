//
//  Publicacion.swift
//  PantallaFeed
//
//  Created by MAC on 24/11/26.
//


import Foundation

struct Publicacion: Identifiable {
    let id: Int
    var documentId: String?
    var title: String?
    var description: String?
    let body: String
    var thumbnail: String?
    var attachments: [PostAttachment] = []
    let authorId: Int
    let createdAt: Date
    var updatedAt: Date?
    var likes: Int = 0
    var hasLiked: Bool = false
    var audiences: Set<String> = []
    var levels: Set<String> = []
}

enum PostAttachment {
    case image(ImageAttachment)
    case video(VideoAttachment)
    case link(LinkAttachment)
    case file(FileAttachment)
}

struct ImageAttachment: Identifiable {
    let id: String
    let url: String
    var width: Int?
    var height: Int?
    var thumbnailUrl: String?
}

struct VideoAttachment: Identifiable {
    let id: String
    let url: String
    var thumbnailUrl: String?
    var duration: Int?
}

struct LinkAttachment: Identifiable {
    let id: String
    let url: String
    var title: String?
    var description: String?
    var thumbnailUrl: String?
}

struct FileAttachment: Identifiable {
    let id: String
    let url: String
    let name: String
    let mimeType: String
    var size: Int?
}
