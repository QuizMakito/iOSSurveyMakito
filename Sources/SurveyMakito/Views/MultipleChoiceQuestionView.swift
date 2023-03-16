//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct MultipleChoiceQuestionView: View {
    @EnvironmentObject public var surveyService: SurveyService

    public let question: SurveyQuestion

    public var body: some View {
        VStack(alignment: .leading) {
            Text(question.title)
                .font(.title2)
                .padding(.bottom, 10)
            if let multiChoices = question.multipleChoice {
                ForEach(multiChoices, id: \.uid) { multipleChoiceQuestion in
                    VStack(alignment: .leading, spacing: 5) {
                        if let choiceQuestions = multipleChoiceQuestion.choices {
                            ForEach(choiceQuestions, id: \.uid) { choice in
                                Button(action: {
                                    // surveyService.setMultipleChoiceQuestionResponse(uid: multipleChoiceQuestion.uid, responseUid: choice.uid)
                                }, label: {
                                    HStack {
                                        /*
                                         if surveyService.getMultipleChoiceQuestionResponse(uid: multipleChoiceQuestion.uid) == choice.uid {
                                         Image(systemName: "checkmark.circle.fill")
                                         .foregroundColor(.white)
                                         } else {
                                         Image(systemName: "circle")
                                         .foregroundColor(.white)
                                         }
                                         */
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.white)
                                        Text(choice.text)
                                            .foregroundColor(.white)
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MultipleChoiceQuestionView_Previews: PreviewProvider {
    static let multipleChoiceQuestion1 = MultipleChoiceQuestion(
        uid: "001",
        choices: [
            MultipleChoiceResponse(uid: "001a", text: "Option A"),
            MultipleChoiceResponse(uid: "001b", text: "Option B"),
            MultipleChoiceResponse(uid: "001c", text: "Option C")
        ],
        allowsMultipleSelection: false
    )
    static let question = SurveyQuestion(
        multipleChoice: [multipleChoiceQuestion1]
    )
    static let survey = Survey(uid: "abcd-1234", questions: [question])

    static var previews: some View {
        SurveyView(survey: .constant(survey), index: .constant(0))
    }
}
