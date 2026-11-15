//
//  Learn.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct Topic: Codable, Identifiable, Hashable, Sendable {

    let id: String
    let title: String
    let code: String

    var category: LearnCategory {
        if id.hasPrefix("topic_swiftui_") {
            return .swiftUI
        }

        if id.hasPrefix("topic_swift_") {
            return .swift
        }

        return .home
    }

    var SFSymbol: String {
        switch category {
        case .swift:
            return "swift"

        case .swiftUI:
            return "swift"

        case .home:
            return "books.vertical"
        }
    }

    var color: Color {
        switch category {
        case .swift:
            return .orange

        case .swiftUI:
            return .blue

        case .home:
            return .white
        }
    }
}
