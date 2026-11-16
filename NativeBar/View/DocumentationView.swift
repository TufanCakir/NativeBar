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

    private var documentations: [Documentation] {
        guard let file = selectedCategory.documentationFile else {
            return []
        }

        return loadLocalJSON(file)
    }

    private var documentationSwift: [Documentation] {
        documentations.filter {
            $0.id.hasPrefix("documentation_swift_")
        }
    }

    private var documentationSwiftUI: [Documentation] {
        documentations.filter {
            $0.id.hasPrefix("documentation_swiftUI_")
        }
    }

    private var currentDocumentationText: String {
        let items: [Documentation]

        switch selectedCategory {
        case .home:
            return "Was möchtest du heute lernen?"

        case .swift:
            items = documentationSwift

        case .swiftUI:
            items = documentationSwiftUI
        }

        return
            items
            .map { "\($0.text)\n\($0.description.localized)" }
            .joined(separator: "\n\n")
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: selectedCategory.backgroundColors,
                    startPoint: .trailing,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                switch selectedCategory {
                case .home:
                    VStack {
                        Text("Was möchtest du heute lernen?")
                    }
                    .font(.system(size: 20))

                case .swift:
                    documentationList(items: documentationSwift)

                case .swiftUI:
                    documentationList(items: documentationSwiftUI)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Schließen") {
                        selectedCategory = .home
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedCategory.accentColor, lineWidth: 3)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kopieren") {
                        UIPasteboard.general.string = currentDocumentationText
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedCategory.accentColor, lineWidth: 3)
                    }
                }

                ToolbarSpacer(.fixed, placement: .topBarTrailing)

                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Kategorie") {
                        ForEach(LearnCategory.allCases.filter { $0 != .home }) {
                            category in
                            Button(category.title) {
                                selectedCategory = category
                            }
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedCategory.accentColor, lineWidth: 3)
                    }
                }
            }
            .tint(selectedCategory.accentColor)
        }
    }

    private func documentationList(items: [Documentation]) -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(items) { documentation in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Label(
                                documentation.text,
                                systemImage: documentation.SFSymbol

                            )
                            .foregroundStyle(documentation.color)
                            .font(.headline)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        selectedCategory.accentColor,
                                        lineWidth: 3
                                    )
                            }

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
                        .foregroundStyle(documentation.color)

                        Text(documentation.description.localized)
                    }
                    .padding()
                    .background(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(documentation.color, lineWidth: 3)
                    }
                }
            }
        }
    }
}

#Preview {
    DocumentationView()
        .preferredColorScheme(.dark)
}
