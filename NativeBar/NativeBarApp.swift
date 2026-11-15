//
//  NativeBarApp.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

@main
struct NativeBarApp: App {

    @State private var searchText: String = ""

    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

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
