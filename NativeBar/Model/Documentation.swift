//
//  Documentation.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct Documentation: Codable, Identifiable, Hashable, Sendable {

    let id: String
    let text: String
    let description: LocalizedDescription

    var category: LearnCategory {
        if id.hasPrefix("documentation_swiftUI_") {
            return .swiftUI
        }

        if id.hasPrefix("documentation_swift_") {
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
            return "document"
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
