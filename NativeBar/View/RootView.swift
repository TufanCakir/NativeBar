//
//  RootView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct RootView: View {

    @State private var searchText: String = ""
    @AppStorage("appLanguage")
    private var appLanguage: String = "system"

    var body: some View {
        TabView {
            Tab {
                LearnView()
            } label: {
                Label("Lernen", systemImage: "books.vertical")
            }
            Tab {
                DocumentationView()
            } label: {
                Label("Dokumentation", systemImage: "document")
            }
            Tab {
                SettingsView()
            } label: {
                Label("Einstellungen", systemImage: "gear")
            }
            Tab(role: .search) {
                NavigationStack {
                    SearchView(searchText: $searchText)
                        .searchable(
                            text: $searchText,
                            prompt: "Durchsuchen"
                        )
                }
            }
        }
        .environment(
            \.locale,
            appLanguage == "system"
                ? Locale.autoupdatingCurrent
                : Locale(identifier: appLanguage)
        )
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewSearchActivation(.searchTabSelection)
        .tint(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView()
}
