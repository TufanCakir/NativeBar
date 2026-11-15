//
//  NativeBarApp.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

@main
struct NativeBarApp: App {

    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

    @AppStorage("appLanguage")
    private var appLanguage: String = "system"

    @AppStorage("appAppearance")
    private var appAppearance: String = "system"

    private var selectedLocale: Locale {
        switch appLanguage {
        case "de":
            return Locale(identifier: "de")

        case "en":
            return Locale(identifier: "en")

        default:
            return .autoupdatingCurrent
        }
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if hasCompletedOnboarding {
                    RootView()
                } else {
                    OnboardingView {
                        hasCompletedOnboarding = true
                    }
                }
            }
        }
    }
}
