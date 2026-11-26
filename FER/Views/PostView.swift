//
//  PublicacionView.swift
//  PantallaFeed
//
//  Created by MAC on 24/11/26.
//

import SwiftUI

struct PublicacionesView: View {
    @State private var PostVM = PublicacionesViewModel()
    @State private var EventVM = EventViewModel()
    @State private var searchText = ""
    @State private var selection: NavTab = .feed

    private let brandBlue = Color(red: 0.13, green: 0.23, blue: 0.53)
    private let logoName = "fer"

    enum FeedItem: Identifiable {
        case post(Publicacion)
        case event(Event)

        var id: String {
            switch self {
            case .post(let post):
                return "post-\(post.id)"
            case .event(let event):
                return "event-\(event.id)"
            }
        }

        var createdAt: Date {
            switch self {
            case .post(let post):
                return post.createdAt
            case .event(let event):
                return event.createdAt
            }
        }
    }
    
    private var filteredFeed: [FeedItem] {
        let posts = selection == .favorites
            ? PostVM.likedPosts
            : PostVM.posts

        let events = selection == .favorites
            ? EventVM.events.filter { $0.hasLiked }
            : EventVM.events

        let combined: [FeedItem] = posts.map { .post($0) }
            + events.map { .event($0) }

        let filtered = searchText.isEmpty
            ? combined
            : combined.filter { item in
                switch item {
                case .post(let post):
                    return (post.title ?? "").localizedCaseInsensitiveContains(searchText) ||
                           (post.description ?? "").localizedCaseInsensitiveContains(searchText)

                case .event(let event):
                    return (event.title).localizedCaseInsensitiveContains(searchText) ||
                           (event.description).localizedCaseInsensitiveContains(searchText)
                }
            }

        return filtered.sorted { $0.createdAt > $1.createdAt }
    }
    
    
    @ViewBuilder
    private func feedRow(for item: FeedItem) -> some View {
        switch item {
        case .post(let post):
            NavigationLink {
                PublicacionDetalle(viewModel: PostVM, postId: post.id)
            } label: {
                PublicacionCard(content: .post(post)) {
                    PostVM.toggleLike(postId: post.id)
                }
            }
            .buttonStyle(.plain)

        case .event(let event):
            NavigationLink {
                EventDetail(
                    viewModel: EventVM,
                    initialEvent: event
                )
            } label: {
                PublicacionCard(content: .event(event)) {
                    EventVM.toggleLike(eventId: event.id)
                }
            }
            .buttonStyle(.plain)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                
                Group {
                    if selection == .feed || selection == .favorites {
                        contentList
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

    private var contentList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                searchBar
                if filteredFeed.isEmpty {
                    Text(selection == .favorites && searchText.isEmpty
                         ? "Aún no tienes favoritos"
                         : "Sin resultados")
                        .foregroundStyle(.secondary)
                        .padding(.top, 40)
                } else {
                    ForEach(filteredFeed) { item in
                        feedRow(for: item)
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
