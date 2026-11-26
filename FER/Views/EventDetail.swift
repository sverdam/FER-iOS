import SwiftUI

struct DetailItem: View {
    let detailLabel: String
    let detailDescription: String
    let detailIcon: Image

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            detailIcon
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(AppTheme.accentBlue, in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(detailLabel)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(detailDescription)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CircleIconButton: View {
    let icon: Image
    var onClick: () -> Void = {}

    var body: some View {
        Button(action: onClick) {
            icon
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.gray)
                .frame(width: 52, height: 52)
                .background(.white, in: Circle())
                .shadow(color: .black.opacity(0.12), radius: 4, y: 2)
        }
        .buttonStyle(.plain)
    }
}


struct EventDetail: View {
    @ObservedObject var viewModel: EventViewModel

    let initialEvent: Event

    private var event: Event {
        viewModel.events.first(where: { $0.id == initialEvent.id }) ?? initialEvent
    }
    
    private var shareText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "EEEE d 'de' MMMM 'a las' h:mm a"
        return "\(event.title)\n\(formatter.string(from: event.dateTime))\n\(event.location)"
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ContentActionButtons(
                    thumbnail: event.photo,
                    shareText: shareText,
                    hasLiked: event.hasLiked
                ) {
                    viewModel.toggleLike(eventId: event.id)
                }
                
                // EVENT INFORMATION
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {

                        // EVENT MAIN INFO
                        HStack(alignment: .top, spacing: 0) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(event.title)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)

                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundStyle(.gray)

                                    Text(event.location)
                                        .foregroundStyle(.secondary)
                                        .font(.body)
                                }
                            }

                            Spacer(minLength: 8)

                            // DATE BADGE
                            VStack(spacing: 4) {
                                Text(event.dateTime.formatted(
                                    .dateTime.day()
                                ))
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(
                                    AppTheme.accentBlue,
                                    in: RoundedRectangle(cornerRadius: 16)
                                )

                                Text(event.dateTime.formatted(
                                    .dateTime.month(.abbreviated)
                                ))
                                .foregroundStyle(.secondary).font(.caption)
                            }
                        }

                        Divider().padding(.vertical, -8)

                        // EVENT DESCRIPTION
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Descripción")
                                .font(.headline)
                                .foregroundStyle(.primary)

                            Text(event.description)
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .lineSpacing(4)
                        }

                        // EVENT DETAILS
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Detalles")
                                .font(.headline)

                            HStack(alignment: .top, spacing: 16) {
                                VStack(alignment: .leading, spacing: 16) {

                                    DetailItem(
                                        detailLabel: "Fecha",
                                        detailDescription: event.dateTime.formatted(
                                            Date.FormatStyle(
                                                date: .abbreviated,
                                                time: .omitted,
                                                locale: Locale(identifier: "es")
                                            )
                                        ),
                                        detailIcon: Image(systemName: "calendar")
                                    )

                                    DetailItem(
                                        detailLabel: "Lugar",
                                        detailDescription: event.location,
                                        detailIcon: Image(systemName: "mappin")
                                    )
                                }

                                VStack(alignment: .leading, spacing: 16) {

                                    DetailItem(
                                        detailLabel: "Horario",
                                        detailDescription: "\(event.dateTime.formatted(date: .omitted, time: .shortened)) - \(event.endDateTime.formatted(date: .omitted, time: .shortened))",
                                        detailIcon: Image(systemName: "clock")
                                    )

                                    DetailItem(
                                        detailLabel: "Costo",
                                        detailDescription: event.cost,
                                        detailIcon: Image(systemName: "dollarsign")
                                    )
                                }
                            }

                            // REGISTRATION
                            DetailItem(
                                detailLabel: "Registro",
                                detailDescription: event.registerLink,
                                detailIcon: Image(systemName: "link")
                            )
                        }

                        // BOTTOM ACTIONS
                        Button(action: {}) {
                            HStack {
                                Text("Agregar al calendario")

                                Spacer()

                                Image(systemName: "calendar")
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(AppTheme.accentBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
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
        }.navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
    }

}

#Preview {
    let viewModel = EventViewModel()

    return EventDetail(
        viewModel: viewModel,
        initialEvent: viewModel.events[0]
    )
}
