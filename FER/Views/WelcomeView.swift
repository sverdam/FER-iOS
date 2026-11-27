import SwiftUI

struct WelcomeView: View {
    let onContinue: (ScholarshipProfile, EducationLevel) -> Void

    @State private var step = 0
    @State private var profile: ScholarshipProfile?
    @State private var level: EducationLevel?

    var body: some View {
        ZStack {
            WelcomeBackground()

            VStack(spacing: 0) {
                StepIndicator(total: 3, current: step)
                    .padding(.horizontal, 48)
                    .padding(.top, 24)

                WelcomeLogo()
                    .padding(.top, 40)

                ZStack {
                    stepContent
                        .id(step)
                        .transition(.asymmetric(
                            insertion: .offset(x: 130).combined(with: .opacity),
                            removal: .offset(x: -130).combined(with: .opacity)
                        ))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 16)

                ContinueButton(
                    text: step == 0 ? "Comenzar" : "Continuar",
                    enabled: canContinue,
                    action: advance
                )
                .padding(.horizontal, 48)
                .padding(.bottom, 32)
            }
        }
    }

    @ViewBuilder
    private var stepContent: some View {
        switch step {
        case 0:
            IntroBody()
        case 1:
            QuestionBody(question: "¿Cuál es tu perfil?") {
                ForEach(ScholarshipProfile.allCases) { option in
                    OptionPill(text: option.rawValue, selected: option == profile) {
                        profile = option
                    }
                }
            }
        default:
            QuestionBody(question: "¿Cuál es tu nivel educativo?") {
                ForEach(EducationLevel.allCases) { option in
                    OptionPill(text: option.rawValue, selected: option == level) {
                        level = option
                    }
                }
            }
        }
    }

    private var canContinue: Bool {
        switch step {
        case 0: return true
        case 1: return profile != nil
        default: return level != nil
        }
    }

    private func advance() {
        if step < 2 {
            withAnimation(.easeInOut(duration: 0.3)) { step += 1 }
        } else if let profile, let level {
            onContinue(profile, level)
        }
    }
}

struct IntroBody: View {
    var body: some View {
        ZStack {
            AnimatedSquiggle()
                .frame(maxHeight: .infinity, alignment: .top)

            VStack(alignment: .leading, spacing: 0) {
                Text("¡Bienvenido!")
                    .font(WelcomeFonts.poppins(50))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text("Personaliza tu experiencia.")
                    .font(WelcomeFonts.poppins(22, medium: false))
                    .tracking(0.3)
                    .foregroundStyle(WelcomeColors.subtitle)
            }
            .padding(.horizontal, 48)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        }
    }
}

struct QuestionBody<Options: View>: View {
    let question: String
    @ViewBuilder let options: Options

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text(question)
                    .font(WelcomeFonts.poppins(20))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 6)
                options
            }
            .padding(.horizontal, 48)
            .padding(.top, 24)
        }
    }
}

#Preview {
    WelcomeView { _, _ in }
}
