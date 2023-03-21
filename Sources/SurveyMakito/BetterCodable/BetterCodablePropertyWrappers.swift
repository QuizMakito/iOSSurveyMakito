//
//  File.swift
//
//
//  Created by Kris Steigerwald on 3/13/23.
//

import Foundation
import BetterCodable

// MARK: - EmptyString
public struct DefaultEmptyStringStrategy: DefaultCodableStrategy {
    public static var defaultValue: String { return "" }
}

/// Decodes String defaulting to `""` if applicable
///
/// `@DefaultEmptyString` decodes Strings and defaults the value to an empty string if the Decoder is unable to decode the value.
public typealias DefaultEmptyString = DefaultCodable<DefaultEmptyStringStrategy>

// MARK: - ZeroInt
public struct DefaultZeroIntStrategy: DefaultCodableStrategy {
    public static var defaultValue: Int { return Int.zero }
}

/// Decodes Int defaulting to `0` if applicable
///
/// `@DefaultZeroInt` decodes Ints and defaults the value to an 0 if the Decoder is unable to decode the value.
public typealias DefaultZeroInt = DefaultCodable<DefaultZeroIntStrategy>

// MARK: - ZeroDouble
public struct DefaultZeroDoubleStrategy: DefaultCodableStrategy {
    public static var defaultValue: Double { return Double.zero }
}

/// Decodes Double defaulting to `0.0` if applicable
///
/// `@DefaultZeroDouble` decodes Doubles and defaults the value to an 0.0 if the Decoder is unable to decode the value.
public typealias DefaultZeroDouble = DefaultCodable<DefaultZeroDoubleStrategy>

// MARK: - Now
public struct DefaultNowStrategy: DefaultCodableStrategy {
    public static var defaultValue: Date { return Date() }
}

/// Decodes Date defaulting to now if applicable
///
/// `@DefaultNow` decodes Dates and defaults the value to now if the Decoder is unable to decode the value.
public typealias DefaultNow = DefaultCodable<DefaultNowStrategy>

// MARK: - Timestamp
public struct DefaultDateStrategy: DefaultCodableStrategy {
    public static var defaultValue: Date { return Date() }
}

/// Decodes Timestamp defaulting to now if applicable
///
/// `@DefaultTimestamp` decodes Timestamps and defaults the value to now if the Decoder is unable to decode the value.
public typealias DefaultTimestamp = DefaultCodable<DefaultDateStrategy>

public struct DefaultDictionaryStrategy: DefaultCodableStrategy {
    public static var defaultValue: [String: String] { return [:] }
}

/// Decodes Dictionary defaulting to [:] if applicable
///
/// `@DefaultDictionary` decodes Timestamps and defaults the value to now if the Decoder is unable to decode the value.
public typealias DefaultDictionary = DefaultCodable<DefaultDictionaryStrategy>

public struct DefaultLogicTypeStrategy: DefaultCodableStrategy {
    public static var defaultValue: LogicType? { return nil }
}

public typealias DefaultEmptyLogicType = DefaultCodable<DefaultLogicTypeStrategy>

public struct DefaultSurveyItemTypeStrategy: DefaultCodableStrategy {
    public static var defaultValue: SurveyItemType? { return nil }
}

public typealias DefaultEmptySurveyItemType = DefaultCodable<DefaultSurveyItemTypeStrategy>

public struct DefaultVisibilityLogicStrategy: DefaultCodableStrategy {
    public static var defaultValue: VisibilityLogic? { return nil }
}

public typealias DefaultVisibilityLogic = DefaultCodable<DefaultVisibilityLogicStrategy>

public struct DefaultMultipleChoiceResponseStrategy: DefaultCodableStrategy {
    public static var defaultValue: [MultipleChoiceResponse]? { return [] }
}

public typealias DefaultMultipleChoiceResponse = DefaultCodable<DefaultMultipleChoiceResponseStrategy>

public struct DefaultMultipleChoiceQuestionStrategy: DefaultCodableStrategy {
    public static var defaultValue: [MultipleChoiceQuestion]? { return [] }
}

public typealias DefaultMultipleChoiceQuestion = DefaultCodable<DefaultMultipleChoiceQuestionStrategy>

public struct DefaultSurveyQuestionsStrategy: DefaultCodableStrategy {
    public static var defaultValue: [SurveyQuestion]? { return [] }
}

public typealias DefaultEmptySurveyQuestions = DefaultCodable<DefaultSurveyQuestionsStrategy>

public struct DefaultSurveyQuestionStrategy: DefaultCodableStrategy {
    public static var defaultValue: SurveyQuestion? { return nil }
}

public typealias DefaultEmptySurveyQuestion = DefaultCodable<DefaultSurveyQuestionStrategy>

public struct DefaultInlineMultipleChoiceQuestionGroupStrategy: DefaultCodableStrategy {
    public static var defaultValue: InlineMultipleChoiceQuestionGroup? { return nil }
}

public typealias DefaultEmptyInlineMultipleChoiceQuestionGroup = DefaultCodable<DefaultInlineMultipleChoiceQuestionGroupStrategy>

public struct DefaultContactFormQuestionStrategy: DefaultCodableStrategy {
    public static var defaultValue: ContactFormQuestion? { return nil }
}

public typealias DefaultEmptyContactFormQuestion = DefaultCodable<DefaultContactFormQuestionStrategy>

public struct DefaultCommentsFormQuestionStrategy: DefaultCodableStrategy {
    public static var defaultValue: CommentsFormQuestion? { return nil }
}

public typealias DefaultEmptyCommentsFormQuestion = DefaultCodable<DefaultCommentsFormQuestionStrategy>

public struct DefaultBinaryQuestionStrategy: DefaultCodableStrategy {
    public static var defaultValue: BinaryQuestion? { return nil }
}

public typealias DefaultEmptyBinaryQuestion = DefaultCodable<DefaultBinaryQuestionStrategy>

public struct DefaultSurveyResponsesStrategy: DefaultCodableStrategy {
    public static var defaultValue: [String: SurveyResponse]? { return [:] }
}

public typealias DefaultEmptySurveyResponsesStrategy = DefaultCodable<DefaultSurveyResponsesStrategy>
