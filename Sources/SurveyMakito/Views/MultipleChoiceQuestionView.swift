//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct MultipleChoiceQuestionView: View {
    @EnvironmentObject public var surveyService: SurveyService
    @State var responseId: String = ""
    @State var selectedIndices: [MultipleChoiceResponse] = []

    public let question: SurveyQuestion
    @Binding var response: SurveyResponse
    public let colors: SurveyColors

    public var body: some View {
        VStack(alignment: .leading) {
            Text(question.title)
                .font(.title2)
                .padding(.bottom, 10)
            if let multiChoices = question.multipleChoice {
                ForEach(multiChoices, id: \.uid) { multipleChoiceQuestion in
                    VStack(alignment: .leading, spacing: 20) {
                        if let choiceQuestions = multipleChoiceQuestion.choices {
                            ForEach(choiceQuestions, id: \.uid) { choice in
                                Button(action: {
                                    selectChoice(choice, multipleChoiceQuestion)
                                }) {
                                    HStack {
                                        Circle()
                                            .fill(appearsIn(choice) ? colors.active : colors.inactive)
                                            .frame(width: 30, height: 30)
                                            .padding(.leading, 20)
                                            .overlay(
                                                appearsIn(choice) ?
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
                                    .background(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke( appearsIn(choice) ? colors.active : colors.inactive, lineWidth: 2)
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: responseId) { _ in
            print(responseId)
            // choiceLookup = surveyService.getMultipleChoiceResponses(from: )

        }
        .onChange(of: selectedIndices) { _ in

            let values = selectedIndices.reduce(into: [:]) { result, response in
                result[response.uid] = Failable(value: response.text)
            }

            response = SurveyResponse(
                uid: UUID().uuidString,
                questionId: question.uid,
                type: .multipleChoiceQuestion,
                values: values
            )
        }
        .onChange(of: question.uid) { _ in
            selectedIndices = response.values.compactMap({ MultipleChoiceResponse(uid: $0.value.uid, text: $0.value.value, selected: true)})
        }
    }

    func loadIndices() {
        guard let surveyResponse = surveyService.responses[question.uid] else { return }
        selectedIndices = surveyService.getMultipleChoiceResponses(from: surveyResponse)
    }

    func appearsIn(_ selectedChoice: MultipleChoiceResponse) -> Bool {
        return selectedIndices.contains(where: {$0.text == selectedChoice.text})
    }

    func selectChoice(_ selectedChoice: MultipleChoiceResponse, _ question: MultipleChoiceQuestion) {
        if question.allowsMultipleSelection {
            toggleSelectedIndex(for: selectedChoice)
        } else {
            setSelectedIndex(for: selectedChoice)
        }
        // updateSelectedChoices()
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
        guard let choices = question.multipleChoice else { return nil }
        return choices.firstIndex { $0.uid == choice.uid }
    }

    private func setSelectedIndex(for selectedChoice: MultipleChoiceResponse) {
        // guard let index = indexOfChoice(selectedChoice) else { return }
        selectedIndices = [selectedChoice]
    }

    private func toggleSelectedIndex(for selectedChoice: MultipleChoiceResponse) {
        if selectedIndices.contains(where: {$0.text == selectedChoice.text}) {
            selectedIndices = selectedIndices.filter { $0.text != selectedChoice.text }
            return
        }
        selectedIndices.append(selectedChoice)
    }

    private func updateSelectedChoices() {
        /*
         for (i, choice) in question.multipleChoice?.enumerated() {
         choice.selected = selectedIndices.contains(i)
         }
         */
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
        SurveyView(
            survey: .constant(survey),
            index: .constant(0),
            event: .constant(.invoke),
            userId: "12345")
    }
}
