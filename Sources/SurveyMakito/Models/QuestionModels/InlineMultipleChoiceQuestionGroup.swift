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


public struct InlineMultipleChoiceQuestionGroup: Codable, Firestorable, Hashable {
    @DefaultEmptyString public var uid: String
    @DefaultMultipleChoiceResponse public var choices: [MultipleChoiceResponse]?
    @DefaultFalse public var allowsMultipleSelection = false
    @DefaultMultipleChoiceQuestion public var questions: [MultipleChoiceQuestion]?


    init(
        uid: String? = nil,
        choices: [MultipleChoiceResponse]? = [],
        allowsMultipleSelection: Bool = false,
        questions: [MultipleChoiceQuestion]? = []
    ) {
        self.uid = uid ?? ""
        self.choices = choices
        self.allowsMultipleSelection = allowsMultipleSelection
        self.questions = questions
    }
}
