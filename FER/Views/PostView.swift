//
//  PublicacionView.swift
//  PantallaFeed
//
//  Created by MAC on 24/11/26.
//

import SwiftUI

struct PublicacionesView: View {
    @State private var viewModel = PublicacionesViewModel()
    @State private var searchText = ""
    @State private var selection: NavTab = .feed

    private let brandBlue = Color(red: 0.13, green: 0.23, blue: 0.53)
    private let logoName = "fer"

    private var filteredPosts: [Publicacion] {
        let base = selection == .favorites ? viewModel.likedPosts : viewModel.posts
        guard !searchText.isEmpty else { return base }
        return base.filter {
            ($0.title ?? "").localizedCaseInsensitiveContains(searchText) ||
            ($0.description ?? "").localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                Group {
                    if selection == .feed || selection == .favorites {
                        postsList
                    } else {
                        Color.clear
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGroupedBackground))
                .safeAreaInset(edge: .bottom) {
                    NavBar(selection: $selection)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var postsList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                searchBar
                if filteredPosts.isEmpty {
                    Text(selection == .favorites && searchText.isEmpty
                         ? "Aún no tienes favoritos"
                         : "Sin resultados")
                        .foregroundStyle(.secondary)
                        .padding(.top, 40)
                } else {
                    ForEach(filteredPosts) { post in
                        NavigationLink {
                            PublicacionDetalle(viewModel: viewModel, postId: post.id)
                        } label: {
                            PublicacionCard(post: post) {
                                viewModel.toggleLike(postId: post.id)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
    }

    private var header: some View {
        Image(logoName)
            .resizable()
            .scaledToFit()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(brandBlue.ignoresSafeArea(edges: .top))
    }

    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.title3)
                .foregroundStyle(.secondary)
            TextField("Buscar en publicaciones...", text: $searchText)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(.white, in: Capsule())
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

#Preview {
    PublicacionesView()
}
