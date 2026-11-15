//
//  LocalizedDescription.swift
//  NativeBar
//
//  Created by Tufan Cakir on 15.11.26.
//

import Foundation

struct LocalizedDescription: Codable, Hashable, Sendable {

    let de: String
    let en: String

    // MARK: - Ausgewählte Sprache

    private var selectedLanguage: String {
        let language =
            UserDefaults.standard.string(
                forKey: "appLanguage"
            ) ?? "system"

        switch language {
        case "de", "en":
            return language

        default:
            return Locale.autoupdatingCurrent
                .language
                .languageCode?
                .identifier ?? "en"
        }
    }

    // MARK: - Lokalisierter Text

    var localized: String {
        localized(for: selectedLanguage)
    }

    // MARK: - Sprachabhängiger Text

    func localized(for language: String) -> String {
        switch language {
        case "de":
            return de.isEmpty ? en : de

        case "en":
            return en.isEmpty ? de : en

        default:
            return en.isEmpty ? de : en
        }
    }
}
