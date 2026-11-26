//
//  PublicacionDetalle.swift
//  PantallaFeed
//
//  Created by MAC on 25/11/26.
//

import SwiftUI

struct PublicacionDetalle: View {
    var viewModel: PostViewModel
    let postId: Int

    @Environment(\.dismiss) private var dismiss

    private var post: Post? {
        viewModel.posts.first { $0.id == postId }
    }

    var body: some View {
        if let post {
            content(for: post)
        } else {
            VStack(spacing: 16) {
                Text("No se encontró la publicación")
                    .foregroundStyle(.secondary)
                Button("Regresar") { dismiss() }
            }
        }
    }

    private func content(for post: Post) -> some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ContentActionButtons(
                    thumbnail: post.thumbnail,
                    shareText: post.title ?? post.body,
                    hasLiked: post.hasLiked
                ) {
                    viewModel.toggleLike(postId: post.id)
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 8) {
                            if let title = post.title {
                                Text(title)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                            }

                            Text(dateText(for: post))
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }

                        Divider().padding(.vertical, -8)

                        if let description = post.description {
                            Text(description)
                                .font(.body.weight(.medium))
                        }

                        if !post.body.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text(post.body)
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .lineSpacing(4)
                        }

                        ForEach(Array(post.attachments.enumerated()), id: \.offset) { _, attachment in
                            attachmentView(attachment)
                        }
                    }
                    .padding(24)
                }
                .background(.white)
                .foregroundStyle(.black)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 40,
                        topTrailingRadius: 40
                    )
                )
                .padding(.top, -40)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }


    // MARK: - Fecha

    private func dateText(for post: Post) -> String {
        let formatted = post.createdAt.formatted(
            .dateTime
                .day()
                .month(.wide)
                .year()
                .locale(Locale(identifier: "es_MX"))
        )
        return post.updatedAt != nil ? "\(formatted) (editado)" : formatted
    }

    // MARK: - Adjuntos

    @ViewBuilder
    private func attachmentView(_ attachment: PostAttachment) -> some View {
        switch attachment {
        case .image(let image):
            AsyncImage(url: URL(string: image.url)) { result in
                result.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.15)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 24))

        case .video(let video):
            if let url = URL(string: video.url) {
                Link(destination: url) {
                    ZStack(alignment: .bottomLeading) {
                        Color(white: 0.1)
                        if let thumb = video.thumbnailUrl {
                            AsyncImage(url: URL(string: thumb)) { result in
                                result.resizable().scaledToFill()
                            } placeholder: {
                                Color.clear
                            }
                        }
                        Image(systemName: "play.fill")
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(AppTheme.accentBlue, in: Circle())
                            .padding(16)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }

        case .link(let link):
            if let url = URL(string: link.url) {
                Link(destination: url) {
                    attachmentCard(icon: "link",
                                   title: link.title ?? "Enlace",
                                   subtitle: link.url,
                                   detail: link.description)
                }
                .buttonStyle(.plain)
            }

        case .file(let file):
            if let url = URL(string: file.url) {
                Link(destination: url) {
                    attachmentCard(icon: "paperclip",
                                   title: file.name.isEmpty ? "Archivo" : file.name,
                                   subtitle: file.mimeType,
                                   detail: file.size.map { "\($0 / 1024) KB" })
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func attachmentCard(icon: String,
                                title: String,
                                subtitle: String,
                                detail: String?) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline.weight(.semibold))
                Text(subtitle).font(.caption).foregroundStyle(.secondary)
                if let detail {
                    Text(detail).font(.caption)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
    }
}

#Preview {
    PublicacionDetalle(viewModel: PostViewModel(), postId: 1)
}
