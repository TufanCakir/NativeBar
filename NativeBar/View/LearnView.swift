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

    private var currentTopicText: String {
        let items: [Topic]

        switch selectedCategory {
        case .home:
            return "Was möchtest du zuerst lernen?"
        case .swift:
            items = topicSwift
        case .swiftUI:
            items = topicSwiftUI
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

    private func topicList(items: [Topic]) -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(items) { topic in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Label(
                                topic.text,
                                systemImage: topic.SFSymbol
                            )
                            .font(.headline)

                            Spacer()

                            Button {
                                UIPasteboard.general.string = topic.text
                                copiedID = topic.id
                            } label: {
                                Image(
                                    systemName: copiedID == topic.id
                                        ? "checkmark" : "doc.on.doc"
                                )
                            }
                        }

                        Text(topic.description)
                            .font(.subheadline)
                    }
                    .foregroundStyle(topic.color)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    LearnView()
}
