//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct InlineMultipleChoiceQuestionGroupView: View {

    @State var selectedIndices: [String: InlineChoiceResponse] = [:]

    @Binding var question: SurveyQuestion
    @Binding var response: SurveyResponse

    @EnvironmentObject var surveyService: SurveyService

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.title)
                .font(.title2)
                .padding(.bottom, 10)
            if let inlineChoices = Binding<[InlineChoiceQuestionGroup]>($question.inlineMultipleChoice) {
                ScrollView(showsIndicators: false) {
                    ForEach(inlineChoices, id: \.uid) { $inlineChoiceQuestion in
                        VStack(alignment: .leading, spacing: 20) {
                            if let choiceQuestions = Binding<[InlineChoiceQuestion]>($inlineChoiceQuestion.questions) {
                                ForEach(choiceQuestions, id: \.uid) { $choiceQuestion in
                                    InlineMultipleChoiceQuestionView(selectedIndices: $selectedIndices, question: choiceQuestion)
                                }
                            }
                        }.padding(.top)
                    }
                }
            }
            Spacer()
        }
        .cornerRadius(10)
        .onChange(of: selectedIndices) { _ in
            transformIntoResponse()
        }

        .onAppear {
            //            response.values.forEach { key, value in
            //                selectedIndices[key] = InlineChoiceResponse(uid: value.uid, text: value.value)
            //            }
        }
    }

    func transformIntoResponse() {
        let values = selectedIndices.reduce(into: [:]) { result, response in
            result[response.key] = Failable(value: response.value.text)
        }

        response = SurveyResponse(
            uid: UUID().uuidString,
            questionId: question.uid,
            type: .multipleChoiceQuestion,
            values: values
        )
    }
}

public struct InlineMultipleChoiceQuestionView: View {
    @Binding var selectedIndices: [String: InlineChoiceResponse]
    let question: InlineChoiceQuestion
    @EnvironmentObject var surveyService: SurveyService
    public var body: some View {
        VStack {
            Text(question.content)
                .font(.title)
                .fontWeight(.semibold)
                .padding(10)
            HStack(spacing: 10) {
                ForEach(question.choices ?? []) { choice in
                    InlineMultipleChoiceButton(choice: choice, onTap: {
                        selectChoice(selectedChoice: choice, question: question)
                    }, state: appearsIn(choice, question))
                }
            }
        }
        .padding(10)
        .background(
            ZStack {
                Color(.systemGray6)
                RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 4)
            }
        )
        .cornerRadius(10)
        .padding(.horizontal)
    }

    func selectChoice(selectedChoice: InlineChoiceResponse, question: InlineChoiceQuestion) {
        selectedIndices[question.uid] = selectedChoice
    }

    func appearsIn(_ selectedChoice: InlineChoiceResponse, _ question: InlineChoiceQuestion) -> InlineChoiceResponseState {
        //        if !selectedIndices.contains(where: {$0.key == question.uid}) {
        //            return .none
        //        } else {
        if selectedIndices.contains(where: {$0.value.uid == selectedChoice.uid}) {
            return .selected
        } else {
            return .notSelected
        }
        //        }
    }
}

enum InlineChoiceResponseState {
    case selected
    case notSelected
    case none

    var fontWeight: Font.Weight {
        switch self {
        case .selected:
            return .bold
        case .notSelected:
            return .regular
        case .none:
            return .regular
        }
    }

    func bgColor(_ intensity: InlineChoiceIntensity) -> Color {
        switch self {
        case .selected:
            return intensity.color.opacity(0.3)
        case .notSelected:
            return intensity.color.opacity(0.1)
        case .none:
            return intensity.color.opacity(0.15)
        }
    }

    func strokeColor(_ intensity: InlineChoiceIntensity) -> Color {
        switch self {
        case .selected:
            return intensity.color.opacity(0.5)
        case .notSelected:
            return .clear
        case .none:
            return .clear
        }
    }
}

public struct InlineMultipleChoiceButton: View {
    let choice: InlineChoiceResponse
    let onTap: () -> Void
    var intensity: InlineChoiceIntensity {
        choice.intensity ?? .none
    }
    let state: InlineChoiceResponseState

    public var body: some View {
        Button(action: { onTap() }) {
            Text(choice.text)
                .font(.subheadline)
                .fontWeight(state.fontWeight)
                .foregroundColor(Color(.label))
                .multilineTextAlignment(.center)
                .padding(7)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(Color.white)
                        RoundedRectangle(cornerRadius: 20).fill(state.bgColor(intensity))
                        RoundedRectangle(cornerRadius: 20).stroke(state.strokeColor(intensity), lineWidth: 3)
                    }
                )
        }.buttonStyle(.plain)
    }
}

public struct InlineMultipleChoiceQuestionGroupView_Previews: PreviewProvider {
    public static var previews: some View {
        PreviewStruct.preview
        //        InlineMultipleChoiceQuestionGroupView(
        //            question: .constant(
        //                SurveyQuestion(
        //                    uid: "a",
        //                    title: "What new features are important to you?",
        //                    tag: "test",
        //                    type: .inlineQuestionGroup,
        //                    inlineMultipleChoice: [
        //                        InlineChoiceQuestionGroup(
        //                            uid: "1",
        //                            questions: [
        //                                InlineChoiceQuestion(
        //                                    uid: "2",
        //                                    content: "test",
        //                                    choices: [
        //                                        InlineChoiceResponse(uid: "4", intensity: .low),
        //                                        InlineChoiceResponse(uid: "5", intensity: .medium),
        //                                        InlineChoiceResponse(uid: "6", intensity: .high)
        //                                    ]
        //                                ),
        //                                InlineChoiceQuestion(
        //                                    uid: "1",
        //                                    content: "test 2",
        //                                    choices: [
        //                                        InlineChoiceResponse(uid: "1", intensity: .low),
        //                                        InlineChoiceResponse(uid: "2", intensity: .medium),
        //                                        InlineChoiceResponse(uid: "3", intensity: .high)
        //                                    ]
        //                                ),
        //                            ]
        //                        )
        //                    ]
        //                )),
        //            response: .constant(SurveyResponse())
        //        )
    }
}
