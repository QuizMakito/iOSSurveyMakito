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

public struct CommentsFormQuestion: Codable, Firestorable, Hashable {

    @DefaultEmptyString public var uid: String
    @DefaultFalse public var required: Bool = false
    @DefaultMultipleChoiceResponse public var choices: [MultipleChoiceResponse]?
    @DefaultFalse public var allowsMultipleSelection = false

    // Info
    @DefaultEmptyString public var emailAddress: String = ""
    @DefaultEmptyString public var feedback: String = ""

    public init(
        uid: String? = nil,
        required: Bool = false,
        choices: [MultipleChoiceResponse]? = [],
        allowsMultipleSelection: Bool = false,
        emailAddress: String? = nil,
        feedback: String? = nil
    ) {
        self.uid = uid ?? ""
        self.required = required
        self.choices = choices
        self.allowsMultipleSelection = allowsMultipleSelection
        self.emailAddress = emailAddress ?? ""
        self.feedback = feedback ?? ""
    }
}
