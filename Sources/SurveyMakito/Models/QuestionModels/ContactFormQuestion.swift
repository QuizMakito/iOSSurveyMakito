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

public struct ContactFormQuestion: Codable, Firestorable, Hashable {

    @DefaultEmptyString public var uid: String
    @DefaultVisibilityLogic public var visibilityLogic: VisibilityLogic?
    @DefaultMultipleChoiceResponse public var choices: [MultipleChoiceResponse]?
    @DefaultFalse public var allowsMultipleSelection = false
    @DefaultFalse public var required: Bool = false

    // Info
    @DefaultEmptyString public var emailAddress: String = ""
    @DefaultEmptyString public var name: String = ""
    @DefaultEmptyString public var company: String = ""
    @DefaultEmptyString public var phoneNumber: String = ""
    @DefaultEmptyString public var feedback: String = ""

    public init(
        uid: String? = nil,
        required: Bool = false,
        visibilityLogic: VisibilityLogic? = nil,
        choices: [MultipleChoiceResponse]? = [],
        multiSelect: Bool = false,
        emailAddress: String? = nil,
        name: String? = nil,
        company: String? = nil,
        phoneNumber: String? = nil,
        feedback: String? = nil
    ) {
        self.uid = uid ?? ""
        self.required = required
        self.visibilityLogic = visibilityLogic
        self.choices = choices

        self.emailAddress = emailAddress ?? ""
        self.name = name ?? ""
        self.company = company ?? ""
        self.phoneNumber = phoneNumber ?? ""
        self.feedback = feedback ?? ""
    }
}
