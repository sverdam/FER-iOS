import SwiftUI

struct MainFeed: View {
    let postVM: PostViewModel
    @ObservedObject var eventVM: EventViewModel
    let onlyFavorites: Bool

    @State private var searchText = ""

    enum FeedItem: Identifiable {
        case post(Post)
        case event(Event)

        var id: String {
            switch self {
            case .post(let post): return "post-\(post.id)"
            case .event(let event): return "event-\(event.id)"
            }
        }

        var createdAt: Date {
            switch self {
            case .post(let post): return post.createdAt
            case .event(let event): return event.createdAt
            }
        }
    }

    private var filteredFeed: [FeedItem] {
        let posts = onlyFavorites ? postVM.likedPosts : postVM.posts
        let events = onlyFavorites
            ? eventVM.events.filter { $0.hasLiked }
            : eventVM.events

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
                    return event.title.localizedCaseInsensitiveContains(searchText) ||
                           event.description.localizedCaseInsensitiveContains(searchText)
                }
            }

        return filtered.sorted { $0.createdAt > $1.createdAt }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                searchBar
                if filteredFeed.isEmpty {
                    Text(onlyFavorites && searchText.isEmpty
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
            .padding(16)
        }
    }

    @ViewBuilder
    private func feedRow(for item: FeedItem) -> some View {
        switch item {
        case .post(let post):
            NavigationLink {
                PublicacionDetalle(viewModel: postVM, postId: post.id)
            } label: {
                ContentCard(content: .post(post)) {
                    postVM.toggleLike(postId: post.id)
                }
            }
            .buttonStyle(.plain)

        case .event(let event):
            NavigationLink {
                EventDetail(viewModel: eventVM, initialEvent: event)
            } label: {
                ContentCard(content: .event(event)) {
                    eventVM.toggleLike(eventId: event.id)
                }
            }
            .buttonStyle(.plain)
        }
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
    NavigationStack {
        MainFeed(postVM: PostViewModel(), eventVM: EventViewModel(), onlyFavorites: false)
    }
}
