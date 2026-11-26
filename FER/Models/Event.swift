//
//  Event.swift
//  FER
//
//  Created by SOFIA VERDUGO on 24/11/26.
//

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
    let peopleInterested: Int = 0
    let likes: Int = 0
    let hasLiked: Bool = false
    let photo: String
    let createdAt: Date
    let updatedAt: Date
    let audiences: Set<String>
    let levels: Set<String>
}
