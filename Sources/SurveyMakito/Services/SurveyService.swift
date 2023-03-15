//
//  File.swift
//  
//
//  Created by Kris Steigerwald on 3/13/23.
//

import Foundation
import SwiftUI
import FirebaseService
import FirebaseFirestoreSwift
import BetterCodable
import Combine


public final class SurveyService: ObservableObject {
    @Published var surveys: [Survey]  = [Survey]()

    public var cancellables: Set<AnyCancellable> = []


    @MainActor
    public func fetch() async throws {
        surveys = try await FirestoreManager.query(path: SurveyPath.Firestore.surveys, queryItems: [
            QueryItem("isActive", .isEqualTo, true)
        ])
    }
}

