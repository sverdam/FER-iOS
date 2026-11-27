//
//  AboutYouViewModel.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

import Foundation
import Observation

@Observable
class AboutYouViewModel {
    private static let profileKey = "perfil"
    private static let levelKey = "nivel"

    private(set) var welcomeCompleted: Bool
    private(set) var profile: ScholarshipProfile
    private(set) var level: EducationLevel

    init() {
        let storedProfile = UserDefaults.standard.string(forKey: Self.profileKey)
        let storedLevel = UserDefaults.standard.string(forKey: Self.levelKey)

        welcomeCompleted = storedProfile != nil
        profile = ScholarshipProfile.allCases.first { $0.slug == storedProfile } ?? .becado
        level = EducationLevel.allCases.first { $0.slug == storedLevel } ?? .universidad
    }

    func saveWelcome(profile: ScholarshipProfile, level: EducationLevel) {
        self.profile = profile
        self.level = level
        UserDefaults.standard.set(profile.slug, forKey: Self.profileKey)
        UserDefaults.standard.set(level.slug, forKey: Self.levelKey)
        welcomeCompleted = true
    }

    func onProfileSelected(_ profile: ScholarshipProfile) {
        self.profile = profile
        if welcomeCompleted {
            UserDefaults.standard.set(profile.slug, forKey: Self.profileKey)
        }
    }

    func onLevelSelected(_ level: EducationLevel) {
        self.level = level
        if welcomeCompleted {
            UserDefaults.standard.set(level.slug, forKey: Self.levelKey)
        }
    }

    func reset() {
        profile = .aspirante
        level = .universidad
        welcomeCompleted = false
        UserDefaults.standard.removeObject(forKey: Self.profileKey)
        UserDefaults.standard.removeObject(forKey: Self.levelKey)
    }
}
