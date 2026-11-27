//
//  UserProfile.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

struct UserProfile {
    var audience: String? = nil
    var level: String? = nil
}

private extension Set where Element == String {
    func allows(_ value: String?) -> Bool {
        guard let value else { return true }
        return isEmpty || contains(value)
    }
}

func matchesProfile(audiences: Set<String>, levels: Set<String>, profile: UserProfile) -> Bool {
    audiences.allows(profile.audience) && levels.allows(profile.level)
}
