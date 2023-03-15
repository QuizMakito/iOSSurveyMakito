//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

struct MultipleChoiceQuestionView: View {
    @EnvironmentObject var surveyService: SurveyService

    let question: SurveyQuestion

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.title)
                .font(.title2)
                .padding(.bottom, 10)

            ForEach(question.multipleChoice ?? [], id: \.uid) { multipleChoiceQuestion in
                VStack(alignment: .leading, spacing: 5) {

                    ForEach(multipleChoiceQuestion.choices ?? [], id: \.uid) { choice in
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
                                 }*/

                                Text(choice.text)
                            }
                        })
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
        SurveyView(survey: survey)
    }
}
