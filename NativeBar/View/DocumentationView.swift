//
//  DocumentationView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct DocumentationView: View {

    @State private var selectedCategory: LearnCategory = .home
    @State private var copiedID: String?

    private var currentDocumentationText: String {
        let items: [Documentation]

        switch selectedCategory {
        case .home:
            return "Welche Dokumentation willst du zuerst lernen?"
        case .swift:
            items = documentatinoSwift
        case .swiftUI:
            items = documentatinoSwiftUI
        }

        return
            items
            .map { "\($0.text)\n\($0.description)" }
            .joined(separator: "\n\n")
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.black, .gray],
                    startPoint: .trailing,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                switch selectedCategory {
                case .home:
                    ScrollView {
                        VStack(spacing: 12) {
                            Text("Was möchtest du heute lernen?")
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.top)

                case .swift:
                    documentationList(items: documentatinoSwift)

                case .swiftUI:
                    documentationList(items: documentatinoSwiftUI)
                }
            }

            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Schließen") {
                        selectedCategory = .home
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kopieren") {
                        UIPasteboard.general.string = currentDocumentationText
                    }
                }

                ToolbarSpacer(.fixed, placement: .topBarTrailing)

                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Kategorie") {
                        Button("Swift") {
                            selectedCategory = .swift
                        }

                        Button("SwiftUI") {
                            selectedCategory = .swiftUI
                        }
                    }
                }
            }
        }
    }

    private func documentationList(items: [Documentation]) -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(items) { documentation in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Label(
                                documentation.text,
                                systemImage: documentation.SFSymbol
                            )
                            .font(.headline)

                            Spacer()

                            Button {
                                UIPasteboard.general.string = documentation.text
                                copiedID = documentation.id
                            } label: {
                                Image(
                                    systemName: copiedID == documentation.id
                                        ? "checkmark" : "doc.on.doc"
                                )
                            }
                        }

                        Text(documentation.description)
                            .font(.subheadline)
                    }
                    .foregroundStyle(documentation.color)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    DocumentationView()
}
