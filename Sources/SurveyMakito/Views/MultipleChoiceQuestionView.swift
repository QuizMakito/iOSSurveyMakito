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

    @Binding var question: SurveyQuestion
    @Binding var response: SurveyResponse
    public let colors: SurveyColors

    @State var focusedText = ""

    public var body: some View {
        VStack(alignment: .leading) {
            Text(question.title)
                .font(.title2)
                .padding(.bottom, 10)
            if let multiChoices = Binding<[MultipleChoiceQuestion]>($question.multipleChoice) {
                ForEach(multiChoices, id: \.uid) { $multipleChoiceQuestion in
                    VStack(alignment: .leading, spacing: 20) {
                        if let choiceQuestions = Binding<[MultipleChoiceResponse]>($multipleChoiceQuestion.choices) {
                            ForEach(choiceQuestions, id: \.uid) { $choice in
                                VStack(spacing: 0) {
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
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 40)
                                                    .fill(Color.white)
                                                RoundedRectangle(cornerRadius: 40)
                                                    .stroke( appearsIn(choice) ? colors.active : colors.inactive, lineWidth: 2)
                                            }
                                        )

                                    }
                                    if choice.allowsCustomTextEntry && appearsIn(choice) {
                                        TextField(choice.customTextEntry, text: $choice.customTextEntry, onEditingChanged: { _ in
                                            focusedText = choice.uid
                                        })
                                        .textFieldStyle(.roundedBorder)
                                        .padding(12)
                                        .padding(.top, 40)
                                        .background(
                                            ZStack {
                                                Color(.systemGray6)
                                                RoundedRectangle(cornerRadius: 20).stroke(Color(.systemGray3), lineWidth: 4)
                                            }
                                        )
                                        .cornerRadius(20)
                                        .offset(y: -40)
                                        .zIndex(-1)
                                        .transition(.move(edge: .bottom))
                                        .animation(.default, value: appearsIn(choice))
                                    }
                                }.onChange(of: choice.customTextEntry, perform: { _ in
                                    updateCustomText(choice, multipleChoiceQuestion)
                                })
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
            transformIntoResponse()
        }
        .onChange(of: question.uid) { _ in
            selectedIndices = response.values.compactMap({
                MultipleChoiceResponse(uid: $0.value.uid, text: $0.value.value, selected: true)
            })
        }
    }

    func transformIntoResponse() {
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

    func loadIndices() {
        guard let surveyResponse = surveyService.responses[question.uid] else { return }
        selectedIndices = surveyService.getMultipleChoiceResponses(from: surveyResponse)
    }

    func appearsIn(_ selectedChoice: MultipleChoiceResponse) -> Bool {
        return selectedIndices.contains(where: {$0.text == selectedChoice.text || $0.text == selectedChoice.customTextEntry})
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

    func updateCustomText(_ selectedChoice: MultipleChoiceResponse, _ question: MultipleChoiceQuestion) {
        let choice = MultipleChoiceResponse(uid: selectedChoice.uid, text: selectedChoice.customTextEntry, selected: true)
        selectedIndices = selectedIndices.filter({$0.uid != selectedChoice.uid})
        selectedIndices.append(choice)
        transformIntoResponse()
    }

    private func indexOfChoice(_ choice: MultipleChoiceResponse) -> Int? {
        guard let choices = question.multipleChoice else { return nil }
        return choices.firstIndex { $0.uid == choice.uid }
    }

    private func setSelectedIndex(for selectedChoice: MultipleChoiceResponse) {
        if selectedChoice.allowsCustomTextEntry {
            let choice = MultipleChoiceResponse(uid: selectedChoice.uid, text: selectedChoice.customTextEntry, selected: true)
            selectedIndices = [choice]
        } else {
            selectedIndices = [selectedChoice]
        }
    }

    private func addCustomText(for choic: MultipleChoiceResponse) {
        //        selectedIndices.append(selectedCustomChoice)
    }

    private func addCustomText(for choic: MultipleChoiceResponse) {
//        selectedIndices.append(selectedCustomChoice)
    }

    private func addCustomText(for choic: MultipleChoiceResponse) {
//        selectedIndices.append(selectedCustomChoice)
    }
    
    private func toggleSelectedIndex(for selectedChoice: MultipleChoiceResponse) {
        if selectedIndices.contains(where: {$0.uid == selectedChoice.uid}) {
            selectedIndices = selectedIndices.filter { $0.uid != selectedChoice.uid}
            return
        }
        if selectedChoice.allowsCustomTextEntry {
            let choice = MultipleChoiceResponse(uid: selectedChoice.uid, text: selectedChoice.customTextEntry, selected: true)
            selectedIndices.append(choice)
        } else {
            selectedIndices.append(selectedChoice)
        }
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
        PreviewStruct.preview
    }
}
