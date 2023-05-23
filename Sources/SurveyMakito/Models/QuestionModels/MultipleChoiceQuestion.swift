//
//  File.swift
//
//
//  Created by Kris Steigerwald on 3/13/23.
//

import SwiftUI
import BetterCodable
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseService

public struct MultipleChoiceQuestion: Codable, Firestorable, Identifiable, Hashable {
    public var id: String = UUID().uuidString

    @DefaultEmptyString public var uid: String
    @DefaultFalse public var allowsMultipleSelection = false
    @DefaultFalse public var autoAdvanceOnChoice: Bool = false
    @DefaultMultipleChoiceResponse public var choices: [MultipleChoiceResponse]?
    public init(
        uid: String? = nil,
        choices: [MultipleChoiceResponse]? = nil,
        allowsMultipleSelection: Bool = false,
        autoAdvanceOnChoice: Bool = false
    ) {
        self.uid = uid ?? ""
        self.choices = choices
        self.allowsMultipleSelection = allowsMultipleSelection
        self.autoAdvanceOnChoice = autoAdvanceOnChoice
    }
}

public struct MultipleChoiceResponse: Codable, Firestorable, Identifiable, Hashable {
    public var id: String = UUID().uuidString
    @DefaultEmptyString public var uid: String
    @DefaultEmptyString public var text: String
    @DefaultFalse public var selected: Bool = false
    @DefaultFalse public var allowsCustomTextEntry: Bool
    @DefaultEmptyString public var customTextEntry: String = ""
    @DefaultEmptyString public var customTextPlaceholder: String

    public init(
        uid: String? = nil,
        text: String? = nil,
        selected: Bool = false,
        allowCustomTextEntry: Bool = false,
        customTextEntry: String? = nil,
        customTextPlaceholder: String? = nil
    ) {
        self.uid = uid ?? ""
        self.text = text ?? ""
        self.selected = selected
        self.customTextEntry = customTextEntry ?? ""
        self.allowsCustomTextEntry = allowCustomTextEntry
        self.customTextPlaceholder = customTextPlaceholder ?? ""
    }
}

public enum InlineChoiceIntensity: Int, Codable {
    case low
    case medium
    case high
    case none
    
    var color: Color {
        switch self {
        case .low:
            return .pink
        case .medium:
            return .yellow
        case .high:
            return .green
        case .none:
            return .clear
        }
    }
    
    var text: String {
        switch self {
        case .low:
            return "Not Important"
        case .medium:
            return "Somewhat Important"
        case .high:
            return "Very Important"
        case .none:
            return ""
        }
    }
}
