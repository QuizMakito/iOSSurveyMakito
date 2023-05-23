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
    @DefaultInlineChoiceQuestion public var questions: [InlineChoiceQuestion]?

    public init(
        uid: String? = nil,
        questions: [InlineChoiceQuestion]? = []
    ) {
        self.uid = uid ?? ""
        self.questions = questions
    }
}
