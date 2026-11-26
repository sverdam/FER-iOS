//
//  PublicacionCard.swift
//  PantallaFeed
//
//  Created by MAC on 25/11/26.
//

import SwiftUI

enum CardContent {
    case post(Publicacion)
    case event(Event)

    var thumbnail: String? {
        switch self {
        case .post(let post): return post.thumbnail
        case .event(let event): return event.photo
        }
    }

    var title: String? {
        switch self {
        case .post(let post): return post.title
        case .event(let event): return event.title
        }
    }

    var description: String? {
        switch self {
        case .post(let post): return post.description ?? post.body
        case .event(let event): return event.description
        }
    }

    var hasLiked: Bool {
        switch self {
        case .post(let post): return post.hasLiked
        case .event(let event): return event.hasLiked
        }
    }
}

struct PublicacionCard: View {
    let content: CardContent
    let onLike: () -> Void

    private let imageHeight: CGFloat = 180
    private let imageAlignment: Alignment = .top

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            if let thumbnail = content.thumbnail {
                Color.clear
                    .frame(height: imageHeight)
                    .overlay(alignment: imageAlignment) {
                        Image(thumbnail)
                            .resizable()
                            .scaledToFill()
                    }
                    .clipped()
                    .overlay(alignment: .bottomTrailing) {
                        likeButton
                            .padding(12)
                    }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(content.title ?? "")
                    .font(.title3.bold())

                Text(content.description ?? "")
                    .font(.subheadline)
                    .lineLimit(2)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }

    private var likeButton: some View {
        Button(action: onLike) {
            Image(systemName: content.hasLiked ? "heart.fill" : "heart")
                .font(.title3)
                .foregroundStyle(content.hasLiked ? .red : .primary)
                .frame(width: 48, height: 48)
                .background(.white, in: Circle())
        }
        .buttonStyle(.plain)
    }
}
