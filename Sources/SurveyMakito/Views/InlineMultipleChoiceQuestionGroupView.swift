//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct InlineMultipleChoiceQuestionGroupView: View {
    @Binding var question: SurveyQuestion
    @Binding var response: SurveyResponse
    
    @EnvironmentObject var surveyService: SurveyService
    @State var isSelected: Bool = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.title)
                .font(.largeTitle)
                .bold()
            if let inlineChoices = Binding<[InlineMultipleChoiceQuestionGroup]>($question.inlineMultipleChoice) {
                ForEach(inlineChoices, id: \.uid) { $inlineChoiceQuestion in
                    VStack(alignment: .leading, spacing: 20) {
                        if let choiceQuestions = Binding<[InlineChoiceQuestion]>($inlineChoiceQuestion.questions) {
                            ForEach(choiceQuestions, id: \.uid) { $choice in
                                InlineMultipleChoiceQuestionView(question: choice, isSelected: .constant(false))
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

public struct InlineMultipleChoiceQuestionView: View {
    let question: InlineChoiceQuestion
    @EnvironmentObject var surveyService: SurveyService
    @Binding var isSelected: Bool
    public var body: some View {
        VStack {
            Text(question.content)
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            HStack(spacing: 10) {
                ForEach(question.choices ?? []) { choice in
                    InlineMultipleChoiceButton(choice: choice, onTap: {})
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
}


public struct InlineMultipleChoiceButton: View {
    let choice: InlineChoiceResponse
    let onTap: () -> Void
    var intensity: InlineChoiceIntensity {
        choice.intensity ?? .none
    }
    
    public var body: some View {
        Button(action: { onTap() }) {
            Text(choice.text)
                .font(.headline)
                .fontWeight(choice.selected ? .bold : .regular)
                .foregroundColor(Color(.label))
                .multilineTextAlignment(.center)
                .padding(7)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(Color.white)
                        RoundedRectangle(cornerRadius: 20).fill(intensity.color.opacity(0.15))
                    }
                )
        }.buttonStyle(.plain)
    }
}

public struct InlineMultipleChoiceQuestionGroupView_Previews: PreviewProvider {
    public static var previews: some View {
        //        PreviewStruct.preview
        InlineMultipleChoiceQuestionGroupView(
            question: .constant(
                SurveyQuestion(
                    uid: "a",
                    title: "What new features are important to you?",
                    tag: "test",
                    type: .inlineQuestionGroup,
                    inlineMultipleChoice: [
                        InlineMultipleChoiceQuestionGroup(
                            uid: "1",
                            questions: [
                                InlineChoiceQuestion(
                                    content: "test",
                                    choices: [
                                        InlineChoiceResponse(intensity: .low),
                                        InlineChoiceResponse(intensity: .medium),
                                        InlineChoiceResponse(intensity: .high)
                                    ]
                                ),
                            ]
                        ),
                        InlineMultipleChoiceQuestionGroup(
                            uid: "2",
                            questions: [
                                InlineChoiceQuestion(
                                    content: "test",
                                    choices: [
                                        InlineChoiceResponse(intensity: .low),
                                        InlineChoiceResponse(intensity: .medium),
                                        InlineChoiceResponse(intensity: .high)
                                    ]
                                ),
                            ]
                        )
                    ]
                )),
            response: .constant(SurveyResponse())
        )
    }
}
