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
    @DefaultMultipleChoiceResponse public var choices: [MultipleChoiceResponse]?
    @DefaultFalse public var allowsMultipleSelection = false

    public init(
        uid: String? = nil,
        choices: [MultipleChoiceResponse]? = nil,
        allowsMultipleSelection: Bool = false
    ) {
        self.uid = uid ?? ""
        self.choices = choices
        self.allowsMultipleSelection = allowsMultipleSelection
    }
}

public struct MultipleChoiceResponse: Codable, Firestorable, Identifiable, Hashable {
    public var id: String = UUID().uuidString
    @DefaultEmptyString public var uid: String
    @DefaultEmptyString public var text: String
    @DefaultFalse public var selected: Bool = false
    @DefaultFalse public var allowsCustomTextEntry: Bool = false
    @DefaultEmptyString public var customTextEntry: String

    public init(
        uid: String? = nil,
        text: String? = nil,
        selected: Bool = false,
        allowCustomTextEntry: Bool = false,
        customTextEntry: String? = nil
    ) {
        self.uid = uid ?? ""
        self.text = text ?? ""
        self.selected = selected
        self.customTextEntry = customTextEntry ?? ""
        self.allowsCustomTextEntry = allowsCustomTextEntry
    }
}
