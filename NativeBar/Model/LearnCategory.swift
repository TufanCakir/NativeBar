//
//  LearnCategory.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

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
