import Foundation

struct Event: Identifiable {
    let id: Int
    let title: String
    let description: String
    let location: String
    let address: String
    let dateTime: Date
    let endDateTime: Date
    let cost: String
    let registerLink: String
    var likes: Int = 0
    var hasLiked: Bool = false
    let photo: String
    let createdAt: Date
    let updatedAt: Date
    let audiences: Set<String>
    let levels: Set<String>
}
