import Foundation
import Observation

@Observable
class FAQViewModel {
    var items: [FAQItem] = []

    init() {
        loadFAQs()
    }

    func loadFAQs() {
        items = FAQItem.catalogo
    }

    func items(matching searchText: String, category: FAQCategoria?) -> [FAQItem] {
        items.filter { item in
            let matchesCategory = category == nil || item.category == category
            let matchesSearch = searchText.isEmpty ||
                item.question.localizedStandardContains(searchText) ||
                item.answer.localizedStandardContains(searchText)
            return matchesCategory && matchesSearch
        }
    }
}
