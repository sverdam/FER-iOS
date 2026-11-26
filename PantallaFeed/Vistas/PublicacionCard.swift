//
//  PublicacionCard.swift
//  PantallaFeed
//
//  Created by MAC on 25/11/26.
//

import SwiftUI

struct PublicacionCard: View {
    let post: Publicacion
    let onLike: () -> Void

    private let imageHeight: CGFloat = 180
    private let imageAlignment: Alignment = .top   // prueba .center

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let thumbnail = post.thumbnail {
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
                Text(post.title ?? "")
                    .font(.title3.bold())

                Text(post.description ?? post.body)
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
            Image(systemName: post.hasLiked ? "heart.fill" : "heart")
                .font(.title3)
                .foregroundStyle(post.hasLiked ? .red : .primary)
                .frame(width: 48, height: 48)
                .background(.white, in: Circle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PublicacionCard(post: PublicacionesViewModel().posts[0], onLike: {})
        .padding()
        .background(Color(.systemGroupedBackground))
}
