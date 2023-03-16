//
//  File.swift
//
//
//  Created by Kris Steigerwald on 3/16/23.
//

import SwiftUI
import BetterCodable
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseService

struct Failable: Codable, Hashable {
    @DefaultEmptyString public var uid: String
    @DefaultEmptyString public var value: String
    init(uid: String? = UUID().uuidString, value: String? = nil) {
        self.uid = uid ?? ""
        self.value = value ?? ""
    }
}

public struct SurveyResponse: Codable, Firestorable, Identifiable, Hashable {

    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultEmptySurveyItemType public var type: SurveyItemType?
    @DefaultEmptyDictionary var values: [String: Failable]

    init(
        id: String? = nil,
        uid: String? = nil,
        type: SurveyItemType? = nil,
        values: [String: Failable]? = nil
    ) {
        self.id = id
        self.uid = uid ?? ""
        self.type = type
        self.values = values ?? [:]
    }
}
