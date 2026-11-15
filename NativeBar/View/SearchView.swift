//
//  SearchView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct SearchView: View {

    @Binding var searchText: String

    private var allTopics: [Topic] {
        topicSwift + topicSwiftUI
    }

    private var allDocumentations: [Documentation] {
        documentatinoSwift + documentatinoSwiftUI
    }

    private var filteredTopics: [Topic] {
        guard !searchText.isEmpty else { return [] }

        return allTopics.filter { topic in
            topic.text.localizedStandardContains(searchText)
                || topic.description.localizedStandardContains(searchText)
        }
    }

    private var filteredDocumentations: [Documentation] {
        guard !searchText.isEmpty else { return [] }

        return allDocumentations.filter { documentation in
            documentation.text.localizedStandardContains(searchText)
                || documentation.description.localizedStandardContains(
                    searchText
                )
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .gray],
                startPoint: .trailing,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {

                    if searchText.isEmpty {
                        ContentUnavailableView {
                            Label("Suche", systemImage: "magnifyingglass")
                        } description: {
                            Text(
                                "Durchsuche Lernaufgaben und Dokumentationen zu Swift und SwiftUI."
                            )
                        }
                    }

                    if !searchText.isEmpty {

                        if !filteredTopics.isEmpty {
                            Text("Lernen")
                                .font(.title2.bold())

                            ForEach(filteredTopics) { topic in
                                VStack(alignment: .leading, spacing: 8) {
                                    Label(
                                        topic.text,
                                        systemImage: topic.SFSymbol
                                    )
                                    .font(.headline)

                                    Text(topic.description)
                                        .font(.subheadline)
                                }
                                .foregroundStyle(topic.color)
                                .padding()
                            }
                        }

                        if !filteredDocumentations.isEmpty {
                            Text("Dokumentation")
                                .font(.title2.bold())

                            ForEach(filteredDocumentations) { documentation in
                                VStack(alignment: .leading, spacing: 8) {
                                    Label(
                                        documentation.text,
                                        systemImage: documentation.SFSymbol
                                    )
                                    .font(.headline)

                                    Text(documentation.description)
                                        .font(.subheadline)
                                }
                                .foregroundStyle(documentation.color)
                                .padding()
                            }
                        }

                        if filteredTopics.isEmpty
                            && filteredDocumentations.isEmpty
                        {
                            ContentUnavailableView.search(text: searchText)
                        }
                    }
                }
                .padding()
            }
            .foregroundStyle(.white)
        }
    }
}
