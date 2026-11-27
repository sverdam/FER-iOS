import SwiftUI

struct Card<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(AppTheme.surface, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

struct Chevron: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(AppTheme.accentBlue)
    }
}

struct RadioRow: View {
    let title: String
    let isOn: Bool
    var action: () -> Void = {}

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .strokeBorder(isOn ? AppTheme.accentBlue : AppTheme.textSecondary, lineWidth: 2)
                if isOn {
                    Circle()
                        .fill(AppTheme.accentBlue)
                        .padding(5)
                }
            }
            .frame(width: 20, height: 20)

            Text(title)
                .font(.body)
                .foregroundStyle(AppTheme.textPrimary)
        }
        .padding(.vertical, 11)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isOn ? [.isButton, .isSelected] : .isButton)
    }
}
