//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct BinaryQuestionView: View {
    @EnvironmentObject var surveyService: SurveyService
    let question: SurveyQuestion
    @State var checked: Bool = false
    @Binding var response: SurveyResponse

    func setResponse() -> EmptyView {
        guard let item = surveyService.responses[question.uid] else { return EmptyView() }
        self.response = item
        return EmptyView()
    }

    func chosen(choice: MultipleChoiceResponse) -> Bool {
        guard let item = surveyService.responses[question.uid] else { return false }
        return item.uid == choice.uid
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom)
            setResponse()
            if let choices = question.binaryQuestion?.choices {
                ForEach(choices, id: \.uid) { choice in
                    Button(action: {
                        let token = surveyService.setResponseId(question.uid, choice.text)
                        // surveyService.setBinaryQuestionResponse(uid: question.uid, choiceUid: choice.uid)
                        response = SurveyResponse(uid: choice.uid,
                                                  questionId: question.uid,
                                                  type: .binaryChoice, values: [
                                                    token: Failable(uid: choice.uid, value: "selected")
                                                  ])

                    }) {
                        HStack {
                            Text(choice.text)
                                .foregroundColor(.white)
                            Spacer()
                            if chosen(choice: choice) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.9))
        .cornerRadius(10)
    }
}

struct BinaryQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        BinaryQuestionView(question: SurveyQuestion(
            uid: "q1",
            title: "How often do you exercise?",
            tag: "exercise",
            type: .binaryChoice,
            binaryQuestion: BinaryQuestion(
                uid: "b1",
                required: true,
                choices: [
                    MultipleChoiceResponse(uid: "yes", text: "Yes"),
                    MultipleChoiceResponse(uid: "no", text: "No")
                ],
                autoAdvanceOnChoice: true
            )
        ), response: .constant(SurveyResponse()))
    }
}
