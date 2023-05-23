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

public struct InlineChoiceQuestionGroup: Codable, Firestorable, Hashable {
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


public struct InlineChoiceQuestion: Codable, Firestorable, Identifiable, Hashable {
    public var id: String = UUID().uuidString
    @DefaultEmptyString public var uid: String
    @DefaultEmptyString public var content: String
    @DefaultFalse public var autoAdvanceOnChoice: Bool = false
    @DefaultInlineChoiceResponse public var choices: [InlineChoiceResponse]?
    public init(
        uid: String? = nil,
        content: String? = nil,
        choices: [InlineChoiceResponse]? = nil,
        autoAdvanceOnChoice: Bool = false
    ) {
        self.uid = uid ?? ""
        self.content = content ?? ""
        self.choices = choices
        self.autoAdvanceOnChoice = autoAdvanceOnChoice
    }
}

public struct InlineChoiceResponse: Codable, Firestorable, Identifiable, Hashable {
    public var id: String = UUID().uuidString
    @DefaultEmptyString public var uid: String
    @DefaultEmptyString public var text: String
    @DefaultFalse public var selected: Bool = false
    @DefaultEmptyInlineChoiceIntensity public var intensity: InlineChoiceIntensity?
    public init(
        uid: String? = nil,
        text: String? = nil,
        selected: Bool = false,
        intensity: InlineChoiceIntensity = .none
    ) {
        self.uid = uid ?? ""
        self.text = text ?? intensity.text
        self.selected = selected
        self.intensity = intensity
    }
}

