//
//  PublicacionDetalle.swift
//  PantallaFeed
//
//  Created by MAC on 25/11/26.
//

import SwiftUI

struct PublicacionDetalle: View {
    var viewModel: PublicacionesViewModel
    let postId: Int

    @Environment(\.dismiss) private var dismiss

    private var post: Publicacion? {
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

    private func content(for post: Publicacion) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header(for: post)

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        if let title = post.title {
                            Text(title)
                                .font(.title2.weight(.semibold))
                        }
                        Text(dateText(for: post))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Divider()

                    if let description = post.description {
                        Text(description)
                            .font(.body.weight(.medium))
                    }

                    if !post.body.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(post.body)
                            .font(.body)
                    }

                    ForEach(Array(post.attachments.enumerated()), id: \.offset) { _, attachment in
                        attachmentView(attachment)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Imagen con botones

    private func header(for post: Publicacion) -> some View {
        Color.clear
            .frame(height: 320)
            .overlay(alignment: .top) {
                if let thumbnail = post.thumbnail {
                    Image(thumbnail)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.gray.opacity(0.2)
                }
            }
            .clipped()
            .overlay(alignment: .topLeading) {
                circleButton(systemName: "chevron.left") { dismiss() }
                    .padding(.leading, 16)
                    .padding(.top, 56)
            }
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 12) {
                    ShareLink(item: post.title ?? post.body) {
                        circleIcon(systemName: "square.and.arrow.up")
                    }

                    circleButton(
                        systemName: post.hasLiked ? "heart.fill" : "heart",
                        tint: post.hasLiked ? .red : .primary
                    ) {
                        viewModel.toggleLike(postId: post.id)
                    }
                }
                .padding(.trailing, 16)
                .padding(.top, 56)
            }
    }

    private func circleButton(systemName: String,
                              tint: Color = .primary,
                              action: @escaping () -> Void) -> some View {
        Button(action: action) {
            circleIcon(systemName: systemName, tint: tint)
        }
        .buttonStyle(.plain)
    }

    private func circleIcon(systemName: String, tint: Color = .primary) -> some View {
        Image(systemName: systemName)
            .font(.title3)
            .foregroundStyle(tint)
            .frame(width: 44, height: 44)
            .background(.white, in: Circle())
            .shadow(color: .black.opacity(0.15), radius: 3, y: 1)
    }

    // MARK: - Fecha

    private func dateText(for post: Publicacion) -> String {
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
                            .background(Color(red: 0.13, green: 0.23, blue: 0.53), in: Circle())
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
    PublicacionDetalle(viewModel: PublicacionesViewModel(), postId: 1)
}
