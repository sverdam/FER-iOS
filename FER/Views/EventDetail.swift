//
//  EventDetail.swift
//  FER
//
//  Created by SOFIA VERDUGO on 24/11/26.
//

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
                .background(Color(red: 0.12, green: 0.25, blue: 0.58), in: Circle())

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
    let event: Event

    var body: some View {
        

        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // EVENT PHOTO AND BUTTONSbackpack
                GeometryReader { geometry in
                    ZStack(alignment: .top) {

                        Image(event.photo)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height
                            )
                            .clipped()
                            .opacity(0.7)

                        // BACK AND SHARE
                        HStack {
                            CircleIconButton(
                                icon: Image(systemName: "chevron.left")
                            )

                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 60)

                        // LIKE
                        CircleIconButton(
                            icon: Image(systemName: "heart")
                        )
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )
                        .padding(.trailing, 20)
                        .padding(.bottom, 48)
                    }.background(                                    Color(red: 0.12, green: 0.25, blue: 0.58))
                }
                .frame(height: 400)

                // EVENT INFORMATION SHEET
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
                                    Color(red: 0.12, green: 0.25, blue: 0.58),
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
                            .background(Color(red: 0.12, green: 0.25, blue: 0.58))
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
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    EventDetail(event: EventViewModel().events[0])
}
