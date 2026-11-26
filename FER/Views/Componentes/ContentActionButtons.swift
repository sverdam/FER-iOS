import SwiftUI

struct ContentActionButtons: View {
    @Environment(\.dismiss) private var dismiss

    let thumbnail: String?
    let shareText: String
    let hasLiked: Bool
    let onLike: () -> Void

    var body: some View {
        AppTheme.accentBlue
            .frame(height: 320)
            .overlay(alignment: .top) {
                if let thumbnail {
                    Image(thumbnail)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.7)
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
                    ShareLink(item: shareText) {
                        circleIcon(systemName: "square.and.arrow.up")
                    }

                    circleButton(
                        systemName: hasLiked ? "heart.fill" : "heart",
                        tint: hasLiked ? .white : .black,
                        background: hasLiked ? AppTheme.accentBlue : .white,
                        action: onLike
                    )
                }
                .padding(.trailing, 16)
                .padding(.top, 56)
            }
    }

    private func circleButton(systemName: String,
                              tint: Color = .black,
                              background: Color = .white,
                              action: @escaping () -> Void) -> some View {
        Button(action: action) {
            circleIcon(systemName: systemName, tint: tint, background: background)
        }
        .buttonStyle(.plain)
    }

    private func circleIcon(systemName: String,
                            tint: Color = .black,
                            background: Color = .white) -> some View {
        Image(systemName: systemName)
            .font(.title3)
            .foregroundStyle(tint)
            .frame(width: 44, height: 44)
            .background(background, in: Circle())
            .shadow(color: .black.opacity(0.15), radius: 3, y: 1)
            .animation(.easeInOut(duration: 0.2), value: background)
    }
}
