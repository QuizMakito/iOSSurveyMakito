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

public enum LogicType: Int, Codable {
    case choiceMustBeSelected
    case choiceMustNotBeSelected
}

public struct VisibilityLogic: Codable, Hashable {
    @DefaultEmptyLogicType public var type: LogicType?
    @DefaultEmptyString public var choiceId: String
    public init(type: LogicType? = nil, choiceId: String? = nil) {
        self.type = type ?? nil
        self.choiceId = choiceId ?? ""
    }
}
