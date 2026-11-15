//
//  LearnView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct LearnView: View {

    @State private var selectedCategory: LearnCategory = .home
    @State private var copiedID: String?

    private var topics: [Topic] {
        guard let file = selectedCategory.topicFile else {
            return []
        }

        return loadLocalJSON(file)
    }
    private var topicSwift: [Topic] {
        topics.filter {
            $0.id.hasPrefix("topic_swift_")
        }
    }

    private var topicSwiftUI: [Topic] {
        topics.filter {
            $0.id.hasPrefix("topic_swiftui_")
        }
    }

    private var currentTopicText: String {
        let items: [Topic]

        switch selectedCategory {
        case .home:
            return "Was möchtest du heute lernen?"

        case .swift:
            items = topicSwift

        case .swiftUI:
            items = topicSwiftUI
        }

        return
            items
            .map { "\($0.title)\n\($0.code)" }
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
                    VStack {
                        Text("Was möchtest du heute lernen?")
                    }
                    .font(.system(size: 25))

                case .swift:
                    topicList(items: topicSwift)

                case .swiftUI:
                    topicList(items: topicSwiftUI)
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
                        UIPasteboard.general.string = currentTopicText
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
                }
            }
        }
    }

    private func topicList(items: [Topic]) -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(items) { topic in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Label(
                                topic.title,
                                systemImage: topic.SFSymbol
                            )
                            .foregroundStyle(topic.color)
                            .font(.headline)

                            Spacer()

                            Button {
                                UIPasteboard.general.string = topic.title
                                copiedID = topic.id
                            } label: {
                                Image(
                                    systemName: copiedID == topic.id
                                        ? "checkmark" : "doc.on.doc"
                                )
                            }
                        }

                        Text(topic.code)
                            .font(.subheadline)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    LearnView()
        .preferredColorScheme(.dark)
}
