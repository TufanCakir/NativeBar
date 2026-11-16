//
//  LearnCategory.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

enum LearnCategory: String, CaseIterable, Identifiable {

    case home
    case swift
    case swiftUI

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Startseite"
        case .swift: return "Swift"
        case .swiftUI: return "SwiftUI"
        }
    }

    var documentationFile: String? {
        switch self {
        case .home:
            return nil
        case .swift:
            return "swift_documentation.json"
        case .swiftUI:
            return "swiftui_documentation.json"
        }
    }

    var topicFile: String? {
        switch self {
        case .home:
            return nil
        case .swift:
            return "swift_topic.json"
        case .swiftUI:
            return "swiftui_topic.json"
        }
    }
}

extension LearnCategory {
    var accentColor: Color {
        switch self {
        case .home:
            return .white
        case .swift:
            return .orange
        case .swiftUI:
            return .blue
        }
    }
}

extension LearnCategory {
    var backgroundColors: [Color] {
        switch self {
        case .home:
            return [.black, .gray, .black]
        case .swift:
            return [.black, .orange, .black]
        case .swiftUI:
            return [.black, .blue, .black]
        }
    }
}
