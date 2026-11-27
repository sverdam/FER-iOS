//
//  WelcomeComponents.swift
//  FER
//
//  Created by MAC on 26/11/26.
//

import SwiftUI

struct StepIndicator: View {
    let total: Int
    let current: Int  

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(index <= current ? 1 : 0.3))
                    .frame(height: 6)
            }
        }
        .animation(.easeInOut, value: current)
    }
}

struct WelcomeLogo: View {
    var body: some View {
        VStack(spacing: 8) {
            line
            VStack(spacing: 0) {
                Text("Fundación").font(WelcomeFonts.cormorant(34))
                Text("Esposos").font(WelcomeFonts.cormorant(34))
                Text("Rodríguez").font(WelcomeFonts.cormorant(38))
            }
            .foregroundStyle(.white)
            line
        }
    }

    private var line: some View {
        Rectangle()
            .fill(Color.white.opacity(0.7))
            .frame(width: 72, height: 1)
    }
}

struct OptionPill: View {
    let text: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .trailing) {
                Text(text)
                    .font(WelcomeFonts.poppins(17))
                    .tracking(0.4)
                    .frame(maxWidth: .infinity)
                if selected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                }
            }
            .foregroundStyle(selected ? WelcomeColors.navyText : Color.white)
            .padding(.horizontal, 20)
            .frame(height: 52)
            .background(Color.white.opacity(selected ? 1 : 0.12), in: Capsule())
            .overlay(Capsule().strokeBorder(Color.white.opacity(selected ? 1 : 0.35), lineWidth: 1))
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: selected)
    }
}

struct ContinueButton: View {
    let text: String
    let enabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(text)
                    .font(WelcomeFonts.poppins(18))
                    .tracking(0.3)
                Image(systemName: "arrow.right")
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundStyle(WelcomeColors.buttonText)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white, in: Capsule())
        }
        .buttonStyle(.plain)
        .disabled(!enabled)
        .opacity(enabled ? 1 : 0.4)
        .animation(.easeInOut(duration: 0.2), value: enabled)
    }
}
