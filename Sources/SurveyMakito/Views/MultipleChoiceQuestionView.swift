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
    @State var selectedIndices: [Int] = []
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

                                Button(action: { selectChoice(choice, multipleChoiceQuestion) }) {
                                    HStack {
                                        Circle()
                                            .fill(choice.selected ? Color.green : Color(.systemGray5))
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                            .overlay(
                                                choice.selected ?
                                                    Image(systemName: "checkmark")
                                                    .foregroundColor(.white)
                                                    .padding(.leading, 20)
                                                    : nil
                                            )
                                        Text(choice.text)
                                            .font(.title3)
                                            .fontWeight(choice.selected ? .bold : .regular)
                                            .foregroundColor(Color(.label))
                                            .padding()
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func selectChoice(_ selectedChoice: MultipleChoiceResponse, _ question: MultipleChoiceQuestion) {
        if question.allowsMultipleSelection {
            toggleSelectedIndex(for: selectedChoice)
        } else {
            setSelectedIndex(for: selectedChoice)
        }
        updateSelectedChoices()
        scrollToOtherTextFieldIfNecessary(selectedChoice: selectedChoice)
    }

    func updateCustomText(
        _ selectedChoice: MultipleChoiceResponse,
        _ question: MultipleChoiceQuestion,
        _ text: String) {
        // guard let index = indexOfChoice(selectedChoice) else { return }

        // question.choices?[index].customTextEntry = text
        // selectedChoice.customTextEntry = text
    }

    private func indexOfChoice(_ choice: MultipleChoiceResponse) -> Int? {
        // question.choices.firstIndex { $0.uuid == choice.uid }
        return 0
    }

    private func setSelectedIndex(for selectedChoice: MultipleChoiceResponse) {
        guard let index = indexOfChoice(selectedChoice) else { return }
        selectedIndices = [index]
    }

    private func toggleSelectedIndex(for selectedChoice: MultipleChoiceResponse) {
        if let index = indexOfChoice(selectedChoice) {
            // selectedIndices.toggle(index)
        }
    }

    private func updateSelectedChoices() {
        // for (i, choice) in question.choices.enumerated() {
        // choice.selected = selectedIndices.contains(i)
        // }
    }

    private func scrollToOtherTextFieldIfNecessary(selectedChoice: MultipleChoiceResponse) {
        if selectedChoice.allowsCustomTextEntry && selectedChoice.selected {
            // self.scrollProxy.scrollTo(OtherTextFieldID)
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
