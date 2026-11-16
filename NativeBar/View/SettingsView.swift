//
//  SettingsView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 15.11.26.
//

import SwiftUI

struct SettingsView: View {

    @AppStorage("appLanguage")
    private var appLanguage: String = "system"

    @AppStorage("appAppearance")
    private var appAppearance: String = "system"

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.black, .gray, .black],
                    startPoint: .trailing,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 12) {
                    languageSection
                    informationSection
                }
            }
        }
    }

    // MARK: - Sprache

    private var languageSection: some View {
        VStack {
            Text("Wählen Sie Ihre bevorzugte Sprache")

            Picker("Sprache", selection: $appLanguage) {
                Text("System")
                    .tag("system")

                Text("Deutsch")
                    .tag("de")

                Text("Englisch")
                    .tag("en")
            }
            .pickerStyle(.menu)
        }
        .padding()
        .background(.black)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [.black, .white, .black],
                        startPoint: .trailing,
                        endPoint: .leading
                    ),
                    lineWidth: 3
                )
        }
    }

    private var informationSection: some View {
        HStack {
            Text("NativeBar")
            Text("Version")
            Text(appVersion)
            Text("Build")
            Text(buildNumber)
        }
        .padding()
        .background(.black)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [.black, .white, .black],
                        startPoint: .trailing,
                        endPoint: .leading
                    ),
                    lineWidth: 3
                )
        }
    }

    private var appVersion: String {
        Bundle.main.object(
            forInfoDictionaryKey: "CFBundleShortVersionString"
        ) as? String ?? "–"
    }

    private var buildNumber: String {
        Bundle.main.object(
            forInfoDictionaryKey: "CFBundleVersion"
        ) as? String ?? "–"
    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
