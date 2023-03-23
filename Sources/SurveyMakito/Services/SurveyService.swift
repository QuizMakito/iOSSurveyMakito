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

    @Published var surveys: [Survey] = [Survey]()
    @Published var responses: [String: SurveyResponse] = [:]
    @Published var surveyable: Bool = true

    public var cancellables: Set<AnyCancellable> = []

    public init(surveys: [Survey] = [], cancellables: Set<AnyCancellable> = []) {
        self.surveys = surveys
        self.cancellables = cancellables
    }

    @MainActor
    public func fetch() async throws {
        surveys = try await FirestoreManager.query(path: SurveyPath.Firestore.surveys, queryItems: [
            QueryItem("isActive", .isEqualTo, true)
        ])
    }

    @MainActor
    public func hasUserTakenSurvey(userId: String) async throws {
        if let set = try await FirestoreManager<UserSurvey>.read(
            atPath: SurveyPath.Firestore.userSurvey,
            uid: userId).responses {
            surveyable = set.isEmpty
        }
    }

    @MainActor
    func submitSurvey(for uid: String) async throws {
        let userSurvey = UserSurvey(
            id: uid,
            uid: uid,
            responses: responses)
        try await FirestoreManager.update(userSurvey, withUid: userSurvey.uid, atPath: SurveyPath.Firestore.userSurvey)
    }

    public func addResponse(response: SurveyResponse) throws {
        guard response.questionId != "" else { throw SurveyError.keyIsEmpty }
        responses[response.questionId] = response
    }

    public func setResponseId(_ questionUID: String, _ token: String) -> String {
        var hasher = Hasher()
        hasher.combine(questionUID)
        hasher.combine(token)
        return String(hasher.finalize())
    }

    public func log() {
        for (key, value) in responses {
            print("Key: \(key)\nValue: \(value)\n")
        }
    }

    func getMultipleChoiceResponses(from response: SurveyResponse) -> [MultipleChoiceResponse] {
        guard response.type == .multipleChoiceQuestion else {
            return []
        }

        let responses = response.values.values.compactMap { failable -> MultipleChoiceResponse? in
            guard let text = failable.value as? String else {
                return nil
            }

            return MultipleChoiceResponse(text: text, selected: true)
        }

        return responses
    }

}
