//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct InlineMultipleChoiceQuestionGroupView: View {
    let question: SurveyQuestion // InlineMultipleChoiceQuestionGroup
    @EnvironmentObject var surveyService: SurveyService
    @State var isSelected: Bool = false
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let question = question.inlineMultipleChoice {
                if let choices = question.choices {
                    ForEach(choices) { choice in
                        MultipleChoiceButton(
                            choice: choice,
                            isSelected: isSelected,
                            allowsMultipleSelection: question.allowsMultipleSelection,
                            onTap: {
                                /*
                                 surveyService.setMultipleChoiceResponse(
                                 uid: choice.uid,
                                 in: question.uid,
                                 selected: !surveyService.getMultipleChoiceResponse(
                                 uid: choice.uid,
                                 in: question.uid
                                 )
                                 )
                                 */
                            }
                        )
                    }
                }
                if let questions = question.questions {
                    ForEach(questions) { question in
                        InlineMultipleChoiceQuestionView(question: question, isSelected: $isSelected)
                    }
                }
            }

        }
        .padding(.vertical)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

public struct InlineMultipleChoiceQuestionView: View {
    let question: MultipleChoiceQuestion
    @EnvironmentObject var surveyService: SurveyService
    @Binding var isSelected: Bool
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(question.choices ?? []) { choice in
                MultipleChoiceButton(
                    choice: choice,
                    isSelected: isSelected,
                    allowsMultipleSelection: question.allowsMultipleSelection,
                    onTap: {
                        /*
                         surveyService.setMultipleChoiceResponse(
                         uid: choice.uid,
                         in: question.uid,
                         selected: !surveyService.getMultipleChoiceResponse(
                         uid: choice.uid,
                         in: question.uid
                         )
                         )
                         */
                    }
                )
            }
        }
        .padding(.vertical)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

public struct MultipleChoiceButton: View {
    let choice: MultipleChoiceResponse
    let isSelected: Bool
    let allowsMultipleSelection: Bool
    let onTap: () -> Void

    public var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.white)
                Text(choice.text)
                    .font(.body)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isSelected ? Color.accentColor : Color(.systemGray3))
        .cornerRadius(5)
        .padding(.bottom, 5)
    }
}

public struct InlineMultipleChoiceQuestionGroupView_Previews: PreviewProvider {
    public static let question: SurveyQuestion = .init(
        uid: "q1",
        title: "What's your favorite color?",
        tag: "color",
        type: .inlineQuestionGroup,
        inlineMultipleChoice: InlineMultipleChoiceQuestionGroup(
            uid: "imc1",
            choices: [
                MultipleChoiceResponse(uid: "red", text: "Red"),
                MultipleChoiceResponse(uid: "blue", text: "Blue"),
                MultipleChoiceResponse(uid: "green", text: "Green")
            ],
            questions: [
                MultipleChoiceQuestion(
                    uid: "mc1",
                    choices: [
                        MultipleChoiceResponse(uid: "red-shade", text: "Lighter shade"),
                        MultipleChoiceResponse(uid: "red-tone", text: "Darker tone"),
                        MultipleChoiceResponse(uid: "red-neon", text: "Neon"),
                        MultipleChoiceResponse(uid: "red-none", text: "No preference")
                    ],
                    allowsMultipleSelection: true
                ),
                MultipleChoiceQuestion(
                    uid: "mc2",
                    choices: [
                        MultipleChoiceResponse(uid: "blue-shade", text: "Lighter shade"),
                        MultipleChoiceResponse(uid: "blue-tone", text: "Darker tone"),
                        MultipleChoiceResponse(uid: "blue-neon", text: "Neon"),
                        MultipleChoiceResponse(uid: "blue-none", text: "No preference")
                    ],
                    allowsMultipleSelection: true
                ),
                MultipleChoiceQuestion(
                    uid: "mc3",
                    choices: [
                        MultipleChoiceResponse(uid: "green-shade", text: "Lighter shade"),
                        MultipleChoiceResponse(uid: "green-tone", text: "Darker tone"),
                        MultipleChoiceResponse(uid: "green-neon", text: "Neon"),
                        MultipleChoiceResponse(uid: "green-none", text: "No preference")
                    ],
                    allowsMultipleSelection: true
                )
            ]
        )
    )

    public static var previews: some View {
        EmptyView()
    }
}
