//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct CommentsFormQuestionView: View {
    @EnvironmentObject var surveyService: SurveyService

    let question: SurveyQuestion

    @State private var feedback: String = ""
    @State private var emailAddress: String = ""

    public var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Please enter your feedback:")
                    .font(.headline)

                TextEditor(text: $feedback)
                    .frame(height: 150)
                    .border(Color.gray, width: 1)
                    .cornerRadius(8)
                    .padding(.bottom, 16)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Your email address (optional):")
                        .font(.subheadline)

                    TextField("Email", text: $emailAddress)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 16)

            Button(action: submitFeedback) {
                Text("Submit Feedback")
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.bottom, 32)
        }
    }

    private func submitFeedback() {
        // Submit feedback to server
    }
}
public extension CommentsFormQuestionView {
    static let commentsQuestion = CommentsFormQuestion(
        uid: "feedback",
        choices: [
            MultipleChoiceResponse(uid: "EXCELLENT_RESPONSE", text: "Excellent"),
            MultipleChoiceResponse(uid: "GOOD_RESPONSE", text: "Good"),
            MultipleChoiceResponse(uid: "FAIR_RESPONSE", text: "Fair"),
            MultipleChoiceResponse(uid: "POOR_RESPONSE", text: "Poor")
        ],
        allowsMultipleSelection: true,
        emailAddress: "feedback@example.com"
    )

    static var example: CommentsFormQuestionView {
        let question = SurveyQuestion(
            commentsFormQuetion: commentsQuestion
        )
        return CommentsFormQuestionView(question: question)
    }
}

struct CommentsFormQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsFormQuestionView.example
            .environmentObject(SurveyService())
    }
}
