//
//  FaQ.swift
//  FER
//
//  Created by MAC on 25/11/26.
//

import SwiftUI

struct FaQ: View {
    @State private var viewModel = FAQViewModel()
    @State private var searchText = ""
    @State private var selectedFilter: FAQCategoria?
    @State private var expandedID: Int?

    private var filteredFAQs: [FAQItem] {
        viewModel.items(matching: searchText, category: selectedFilter)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Preguntas Frecuentes")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)

            FAQSearchBar(text: $searchText)

            HStack(spacing: 10) {
                FAQFilterButton(title: "Todas", isSelected: selectedFilter == nil) {
                    selectedFilter = nil
                }

                ForEach(FAQCategoria.allCases) { category in
                    FAQFilterButton(
                        title: category.rawValue,
                        isSelected: selectedFilter == category
                    ) {
                        selectedFilter = category
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        if filteredFAQs.isEmpty {
                            Text("Sin resultados")
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                        } else {
                            ForEach(filteredFAQs) { item in
                                FAQQuestionRow(
                                    item: item,
                                    isExpanded: expandedID == item.id
                                ) {
                                    expandedID = (expandedID == item.id) ? nil : item.id
                                }
                            }
                        }
                    }
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
            .frame(maxHeight: .infinity)

            FAQContactBanner()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGroupedBackground))
    }
}

private struct FAQSearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.title3)
                .foregroundStyle(.secondary)

            TextField("Buscar por palabra clave...", text: $text)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(.white, in: Capsule())
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

private struct FAQFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? FAQEstilo.marca : .white)
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? FAQEstilo.marca : Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

private struct FAQQuestionRow: View {
    let item: FAQItem
    let isExpanded: Bool
    let onToggle: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Button(action: onToggle) {
                HStack {
                    Text(item.question)
                        .font(.body)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.primary)

                    Spacer()

                    Image(systemName: isExpanded ? "xmark" : "plus")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(FAQEstilo.marca)
                }
                .padding(.horizontal)
                .padding(.vertical, 14)
            }
            .buttonStyle(.plain)

            if isExpanded {
                Text(item.answer)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                    .padding(.bottom, 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Divider()
                .padding(.horizontal)
        }
    }
}

private struct FAQContactBanner: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "questionmark.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 4) {
                Text("¿Aun tienes dudas?")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("Estamos aqui para orientarte")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))

                Text("Contactanos por medio de:")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                    .padding(.top, 4)

                Text("celular: 662 212 1453")
                    .font(.caption)
                    .foregroundStyle(.white)

                Text("correo: info@fer.org.mx")
                    .font(.caption)
                    .foregroundStyle(.white)
            }

            Spacer()
        }
        .padding()
        .background(FAQEstilo.marca)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

private enum FAQEstilo {
    static let marca = Color(red: 0.13, green: 0.23, blue: 0.53)
}

#Preview {
    FaQ()
}
