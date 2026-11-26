//
//  NavBar.swift
//  PantallaFeed
//
//  Created by MAC on 24/11/26.
//


import SwiftUI

enum NavTab: CaseIterable {
    case feed, favorites, calendar, info, settings

    var icon: String {
        switch self {
        case .feed: "house"
        case .favorites: "heart"
        case .calendar: "calendar"
        case .info: "info.circle"
        case .settings: "gearshape"
        }
    }

    var selectedIcon: String {
        switch self {
        case .feed: "house.fill"
        case .favorites: "heart.fill"
        case .calendar: "calendar"
        case .info: "info.circle.fill"
        case .settings: "gearshape.fill"
        }
    }
}

struct NavBar: View {
    @Binding var selection: NavTab

    private let activeColor = Color(red: 0.13, green: 0.23, blue: 0.53)

    var body: some View {
        HStack {
            ForEach(NavTab.allCases, id: \.self) { tab in
                Button {
                    selection = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: selection == tab ? tab.selectedIcon : tab.icon)
                            .font(.system(size: 26))
                            .foregroundStyle(selection == tab ? activeColor : .gray)

                        Capsule()
                            .fill(selection == tab ? activeColor : .clear)
                            .frame(width: 28, height: 4)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(.white, in: Capsule())
        .shadow(color: .black.opacity(0.12), radius: 6, y: 2)
        .padding(.horizontal, 16)
    }
}

#Preview {
    NavBar(selection: .constant(.feed))
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
}
