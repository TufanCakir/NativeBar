//
//  ContentView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct RootView: View {

    @State private var searchText: String = ""

    var body: some View {
        TabView {
            Tab {
                LearnView()
            } label: {
                Label("Lernen", systemImage: "book")
            }

            Tab {
                DocumentationView()
            } label: {
                Label("Dokumentation", systemImage: "document")
            }
            Tab(role: .search) {
                NavigationStack {
                    SearchView(searchText: $searchText)
                        .navigationBarTitleDisplayMode(.inline)
                        .searchable(
                            text: $searchText,
                            prompt: "Search"
                        )
                }
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewSearchActivation(.searchTabSelection)
        .tint(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootView()
}
