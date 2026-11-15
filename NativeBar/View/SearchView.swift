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
        loadLocalJSON("swift_topic.json")

    private let allDocumentations: [Documentation] =
        loadLocalJSON("swift_documentation.json")

    // MARK: - Suche

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

    // MARK: - Layout

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .gray],
                startPoint: .trailing,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    if normalizedSearchText.isEmpty {
                        emptySearchView
                    } else {
                        searchResults
                    }
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .foregroundStyle(.white)
    }

    // MARK: - Suchergebnisse

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

    // MARK: - Startansicht

    private var emptySearchView: some View {
        ContentUnavailableView {
            Label(
                "Suche",
                systemImage: "magnifyingglass"
            )
        } description: {
            Text(
                "Lerninhalte und Dokumentation durchsuchen"
            )
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Überschriften

    private func resultHeader(
        _ title: String,
        symbol: String,
        count: Int
    ) -> some View {
        HStack(spacing: 10) {
            Label(title, systemImage: symbol)
                .font(.title3.bold())

            Spacer()

            Text(count, format: .number)
                .font(.caption.bold())
                .foregroundStyle(.white.opacity(0.7))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.white.opacity(0.1), in: Capsule())
        }
        .padding(.top, 8)
    }

    // MARK: - Ergebniskarten

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
                    .font(.headline)
                    .foregroundStyle(color)

                Spacer(minLength: 8)

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
                        copiedID == id ? .green : .white
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Ergebnis kopieren")
            }

            Text(description)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .textSelection(.enabled)
        }
        .padding(16)
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white.opacity(0.08))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.white.opacity(0.1))
        }
    }
}
