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

public struct BinaryQuestion: Codable, Firestorable, Hashable {

    @DefaultEmptyString public var uid: String
    @DefaultFalse public var required: Bool = false
    @DefaultVisibilityLogic public var visibilityLogic: VisibilityLogic?
    @DefaultMultipleChoiceResponse public var choices: [MultipleChoiceResponse]?
    @DefaultFalse public var allowsMultipleSelection = false
    @DefaultFalse public var autoAdvanceOnChoice: Bool = false

    init(
        uid: String? = nil,
        required: Bool = false,
        visibilityLogic: VisibilityLogic? = nil,
        choices: [MultipleChoiceResponse]? = nil,
        allowsMultipleSelection: Bool = false,
        autoAdvanceOnChoice: Bool = false
    ) {
        self.uid = uid ?? ""
        self.required = required
        self.visibilityLogic = visibilityLogic
        self.choices = choices
        self.allowsMultipleSelection = allowsMultipleSelection
        self.autoAdvanceOnChoice = autoAdvanceOnChoice
    }
}
