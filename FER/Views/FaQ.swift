//
//  FaQ.swift
//  FER
//
//  Created by MAC on 25/11/26.
//

import SwiftUI

struct FaQ: View {
    @State private var searchText = ""
    @State private var selectedFilter = "Todas"
    @State private var expandedID: UUID? = nil
    
    let filters = ["Todas", "Aspirantes", "Becarios"]
    
    let faqs: [FAQItem] = [
        FAQItem(
            question: "¿Qué niveles educativos cuentan con becas?",
            answer: "Respuesta de ejemplo para los niveles educativos con beca.",
            category: "Aspirantes"
        ),
        FAQItem(
            question: "¿Cómo puedo solicitar una beca?",
            answer: "Para solicitar una beca debes registrarte en la plataforma, completar el formulario y adjuntar los documentos requeridos.",
            category: "Becarios"
        ),
        FAQItem(
            question: "¿Cuáles son los requisitos para ser becario?",
            answer: "Los requisitos principales son promedio mínimo, estar inscrito en una institución educativa y no tener otra beca vigente.",
            category: "Becarios"
        ),
        FAQItem(
            question: "¿Hasta cuándo puedo aplicar?",
            answer: "Las convocatorias suelen cerrar a finales de cada semestre. Revisa las fechas en la sección de convocatorias.",
            category: "Aspirantes"
        ),
        FAQItem(
            question: "¿Puedo tener más de una beca al mismo tiempo?",
            answer: "No, solo se permite una beca vigente por persona. Debes renunciar a la anterior si quieres aplicar a una nueva.",
            category: "Becarios"
        ),
        FAQItem(
            question: "¿Qué documentos necesito para el registro?",
            answer: "Identificación oficial, comprobante de domicilio, constancia de estudios y promedio actualizado.",
            category: "Aspirantes"
        ),
        FAQItem(
            question: "¿Cómo puedo dar seguimiento a mi solicitud?",
            answer: "Puedes revisar el estado de tu solicitud iniciando sesión con tu correo y contraseña en la sección de Mi Cuenta.",
            category: "Becarios"
        )
    ]
    
    var filteredFAQs: [FAQItem] {
        faqs.filter { item in
            let matchesFilter = selectedFilter == "Todas" || item.category == selectedFilter
            let matchesSearch = searchText.isEmpty ||
                item.question.localizedCaseInsensitiveContains(searchText) ||
                item.answer.localizedCaseInsensitiveContains(searchText)
            return matchesFilter && matchesSearch
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Preguntas Frecuentes")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SearchBar(text: $searchText)
            
            HStack(spacing: 10) {
                ForEach(filters, id: \.self) { filter in
                    FilterButton(
                        title: filter,
                        isSelected: selectedFilter == filter
                    ) {
                        selectedFilter = filter
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(filteredFAQs) { item in
                            QuestionElement(
                                item: item,
                                isExpanded: expandedID == item.id
                            ) {
                                toggleExpansion(item.id)
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
            .frame(maxHeight: .infinity)
            
            ContactBanner()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(.systemGroupedBackground))
    }
    
    private func toggleExpansion(_ id: UUID) {
        expandedID = (expandedID == id) ? nil : id
    }
}

//Modelos
struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    let category: String
}

//Componentes
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("Buscar por palabra clave...", text: $text)
                .textFieldStyle(.plain)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.blue, lineWidth: 1.5)
        )
    }
}

struct FilterButton: View {
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
                .background(isSelected ? Color.blue : Color.white)
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.blue : Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
    }
}

struct QuestionElement: View {
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
                        .foregroundStyle(.blue)
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

struct ContactBanner: View {
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
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    FaQ()
}
