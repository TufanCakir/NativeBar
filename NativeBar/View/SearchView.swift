//
//  SearchView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI
import UIKit

struct SearchView: View {

    @Binding var searchText: String

    @State private var copiedID: String?

    private let allTopics: [Topic] =
        LearnCategory.allCases.flatMap { category in
            guard let file = category.topicFile else {
                return [Topic]()
            }

            return loadLocalJSON(file) as [Topic]
        }

    private let allDocumentations: [Documentation] =
        LearnCategory.allCases.flatMap { category in
            guard let file = category.documentationFile else {
                return [Documentation]()
            }

            return loadLocalJSON(file) as [Documentation]
        }

    private var normalizedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var filteredTopics: [Topic] {
        guard !normalizedSearchText.isEmpty else {
            return []
        }

        return allTopics.filter { topic in
            matches(
                title: topic.title,
                german: topic.code,
                english: topic.code
            )
        }
    }

    private var filteredDocumentations: [Documentation] {
        guard !normalizedSearchText.isEmpty else {
            return []
        }

        return allDocumentations.filter { documentation in
            matches(
                title: documentation.text,
                german: documentation.description.de,
                english: documentation.description.en
            )
        }
    }

    private func matches(
        title: String,
        german: String,
        english: String
    ) -> Bool {
        title.localizedStandardContains(normalizedSearchText)
            || german.localizedStandardContains(normalizedSearchText)
            || english.localizedStandardContains(normalizedSearchText)
    }

    private var primaryResultColor: Color? {
        if let firstTopic = filteredTopics.first {
            return firstTopic.color
        }
        if let firstDoc = filteredDocumentations.first {
            return firstDoc.color
        }
        return nil
    }

    private var dynamicBackgroundColors: [Color] {
        guard let color = primaryResultColor else {
            return [.black, .gray]
        }
        return [.black, color]
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: dynamicBackgroundColors,
                startPoint: .trailing,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    if normalizedSearchText.isEmpty {
                        emptySearchView
                    } else {
                        searchResults
                    }
                }
                .padding()
            }
            .tint(primaryResultColor ?? .white)
            .scrollDismissesKeyboard(.immediately)
        }
    }

    @ViewBuilder
    private var searchResults: some View {

        if filteredTopics.isEmpty
            && filteredDocumentations.isEmpty
        {
            ContentUnavailableView.search(
                text: normalizedSearchText
            )
        } else {
            if !filteredTopics.isEmpty {
                resultHeader(
                    "Lernen",
                    symbol: "books.vertical",
                    count: filteredTopics.count
                )
                .padding()
                .background(.black)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.orange, lineWidth: 3)
                }
                .foregroundStyle(.orange)

                ForEach(filteredTopics) { topic in
                    resultCard(
                        id: "topic_\(topic.id)",
                        title: topic.title,
                        description: topic.code,
                        symbol: topic.SFSymbol,
                        color: topic.color
                    )
                }
            }

            if !filteredDocumentations.isEmpty {
                resultHeader(
                    "Dokumentation",
                    symbol: "document",
                    count: filteredDocumentations.count
                )
                .padding()
                .background(.blue)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.orange, lineWidth: 3)
                }
                .foregroundStyle(.blue)

                ForEach(filteredDocumentations) { documentation in
                    resultCard(
                        id: "documentation_\(documentation.id)",
                        title: documentation.text,
                        description: documentation.description.localized,
                        symbol: documentation.SFSymbol,
                        color: documentation.color
                    )
                }
            }
        }
    }

    private var emptySearchView: some View {
        ContentUnavailableView {
            Text("Lerninhalte und Dokumentation durchsuchen")
        }
    }

    private func resultHeader(
        _ title: String,
        symbol: String,
        count: Int
    ) -> some View {
        HStack(spacing: 12) {
            Label(title, systemImage: symbol)

            Spacer()

            Text(count, format: .number)
        }
    }

    private func resultCard(
        id: String,
        title: String,
        description: String,
        symbol: String,
        color: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Label(title, systemImage: symbol)
                    .foregroundStyle(color)

                Spacer()

                Button {
                    UIPasteboard.general.string =
                        "\(title)\n\(description)"

                    copiedID = id
                } label: {
                    Image(
                        systemName: copiedID == id
                            ? "checkmark"
                            : "doc.on.doc"
                    )
                    .contentTransition(
                        .symbolEffect(.replace)
                    )
                    .foregroundStyle(
                        copiedID == id ? .green : color
                    )
                }
                .accessibilityLabel("Ergebnis kopieren")
            }

            Text(description)

        }
        .padding()
        .background(.black)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(color, lineWidth: 3)
        }
    }
}
