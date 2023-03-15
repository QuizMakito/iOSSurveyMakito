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

public struct Survey: Codable, Firestorable, Identifiable, Hashable {
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultEmptySurveyQuestions public var questions: [SurveyQuestion]?

    public init(
        id: String? = nil,
        uid: String? = nil,
        questions: [SurveyQuestion] = []
    ) {
        self.id = id
        self.uid = uid ?? ""
        self.questions = questions
    }
}
