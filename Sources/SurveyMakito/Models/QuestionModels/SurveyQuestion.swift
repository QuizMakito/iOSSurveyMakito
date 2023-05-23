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

public enum SurveyItemType: Int, Codable {
    case multipleChoiceQuestion
    case binaryChoice
    case contactForm
    case inlineQuestionGroup
    case commentsForm
}

public struct SurveyQuestion: Codable, Hashable, Identifiable {
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultEmptyString public var title: String
    @DefaultEmptyString public var tag: String
    @DefaultEmptySurveyItemType public var type: SurveyItemType?
    @DefaultEmptyIsRequired public var isRequired: Bool

    // Multiple Choice
    @DefaultMultipleChoiceQuestion public var multipleChoice: [MultipleChoiceQuestion]?

    // Default Inline MC
    @DefaultEmptyInlineMultipleChoiceQuestionGroup
    public var inlineMultipleChoice: [InlineMultipleChoiceQuestionGroup]?

    @DefaultEmptyContactFormQuestion
    public var contactFormQuestion: ContactFormQuestion?

    @DefaultEmptyCommentsFormQuestion
    public var commentsFormQuetion: CommentsFormQuestion?

    @DefaultEmptyBinaryQuestion
    public var binaryQuestion: BinaryQuestion?

    public init(uid: String? = nil,
                title: String? = nil,
                tag: String? = nil,
                type: SurveyItemType? = nil,
                surveyItemType: SurveyItemType? = .none,
                isRequired: Bool? = nil,
                multipleChoice: [MultipleChoiceQuestion]? = [],
                inlineMultipleChoice: [InlineMultipleChoiceQuestionGroup]? = [],
                contactFormQuestion: ContactFormQuestion? = nil,
                commentsFormQuetion: CommentsFormQuestion? = nil,
                binaryQuestion: BinaryQuestion? = nil

    ) {
        self.uid = uid ?? ""
        self.title = title ?? ""
        self.tag = tag ?? ""
        self.type = type ?? nil
        self.isRequired = isRequired ?? true
        self.multipleChoice = multipleChoice
        self.inlineMultipleChoice = inlineMultipleChoice
        self.contactFormQuestion = contactFormQuestion
        self.commentsFormQuetion = commentsFormQuetion
        self.binaryQuestion = binaryQuestion
    }
}
