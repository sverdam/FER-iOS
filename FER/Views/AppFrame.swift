//
//  AppFrame.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

import SwiftUI

struct AppFrame: View {
    @State private var viewModel = AboutYouViewModel()
    @State private var postVM = PostViewModel()
    @StateObject private var eventVM = EventViewModel()
    @State private var selection: NavTab = .feed

    var body: some View {
        if viewModel.welcomeCompleted {
            mainApp
        } else {
            WelcomeView { profile, level in
                viewModel.saveWelcome(profile: profile, level: level)
            }
        }
    }

    private var mainApp: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FerHeader()

                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGroupedBackground))
                    .safeAreaInset(edge: .bottom) {
                        NavBar(selection: $selection)
                    }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch selection {
        case .feed:
            MainFeed(postVM: postVM, eventVM: eventVM, onlyFavorites: false)
        case .favorites:
            MainFeed(postVM: postVM, eventVM: eventVM, onlyFavorites: true)
        case .info:
            FaQ()
        case .settings:
            Color.clear  
        }
    }
}

#Preview {
    AppFrame()
}
