import SwiftUI

struct SettingsView: View {
    @AppStorage("appearance") private var appearance: AppearanceMode = .system
    @AppStorage("textSize") private var textSize: TextSizeOption = .normal
    @Environment(\.dynamicTypeSize) private var systemTextSize
    @Environment(\.scenePhase) private var scenePhase
    @State private var notificationsOn = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Ajustes")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Card {
                    HStack {
                        Text("Sobre ti")
                            .font(.body)
                        Spacer()
                        Chevron()
                    }
                }

                Button {
                    Task {
                        await NotificationPermission.requestOrOpenSettings()
                        await refreshNotifications()
                    }
                } label: {
                    Card {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Notificaciones del teléfono")
                                    .font(.body)
                                Text(notificationsOn
                                     ? "Los avisos están activados"
                                     : "Los avisos están desactivados")
                                    .font(.footnote)
                                    .foregroundStyle(AppTheme.textSecondary)
                            }
                            Spacer()
                            Chevron()
                        }
                    }
                }
                .buttonStyle(.plain)

                Card {
                    Text("Apariencia")
                        .font(.body)
                        .padding(.bottom, 6)
                    ForEach(AppearanceMode.allCases) { option in
                        RadioRow(title: option.title, isOn: appearance == option) {
                            appearance = option
                        }
                    }
                }

                Card {
                    Text("Accesibilidad")
                        .font(.body)
                    Text("Tamaño del texto")
                        .font(.caption)
                        .foregroundStyle(AppTheme.textSecondary)
                        .padding(.top, 6)
                        .padding(.bottom, 4)
                    ForEach(TextSizeOption.allCases) { option in
                        RadioRow(title: option.title, isOn: textSize == option) {
                            textSize = option
                        }
                    }
                }

                Card {
                    Text("Borrar datos de este telefono")
                        .font(.body)
                        .foregroundStyle(AppTheme.destructiveText)
                }

                Card {
                    Text("Acerca de")
                        .font(.body)
                        .padding(.bottom, 10)
                    VStack(alignment: .leading, spacing: 9) {
                        Text("Fundacion Esposos Rodriguez")
                        Text("Version 1.0")
                        Text("celular: 662 212 1453")
                        Text("correo: info@fer.org.mx")
                        Text("Los datos de Sobre ti se quedan en este telefono")
                    }
                    .font(.subheadline)
                }
            }
            .foregroundStyle(AppTheme.textPrimary)
            .padding(16)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .dynamicTypeSize(textSize.applied(to: systemTextSize))
        .task { await refreshNotifications() }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                Task { await refreshNotifications() }
            }
        }
    }

    private func refreshNotifications() async {
        notificationsOn = await NotificationPermission.isEnabled()
    }
}

#Preview {
    SettingsView()
}
