//
//  SwiftUIView.swift
//
//
//  Created by Kris Steigerwald on 3/16/23.
//

import SwiftUI

struct SurveyNavigationFooterView: View {
    var questions: [SurveyQuestion]
    @Binding var index: Int
    @Binding var isAnimating: Bool
    @Binding var event: SurveyEvent
    @Binding var canGoNext: Bool

    private let buttonTextColor = Color.blue
    private let buttonBackgroundColor = Color.white

    public var currentQuestion: SurveyQuestion {
        return questions[index]
    }

    var body: some View {
        HStack {
            Button(action: {
                event = .back
                withAnimation {
                    index = (index - 1) % questions.count
                    isAnimating = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation {
                        isAnimating = false
                    }
                }

            }) {
                buttonView(label: "Back", fontColor: .gray, bgColor: Color(.systemGray4))
            }
            .opacity(index > 0 ? 1 : 0)
            Spacer()
            if canGoNext {
                if index == questions.count - 1 {
                    Button(action: {
                        event = .submit
                    }) {
                        buttonView(label: "Submit Survey")
                    }
                }
            }
            if index < questions.count - 1 && canGoNext && currentQuestion.isRequired {
                Button(action: {
                    event = .next
                }) {
                    buttonView(label: "Next")
                }
                .opacity(questions.isEmpty || index >= (questions.count - 1) ? 0 : 1)
            }
        }
    }

    func buttonView(label: String = "Next", fontColor: Color = .white, bgColor: Color = .blue) -> some View {
        Text(label)
            .foregroundColor(fontColor)
            .padding(8)
            .fontWeight(.semibold)
            .padding(.horizontal, 25)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(bgColor)
            )
    }
}

struct SurveyNavigationFooterView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyNavigationFooterView(
            questions: [SurveyQuestion(), SurveyQuestion()],
            index: .constant(1),
            isAnimating: .constant(false),
            event: .constant(.invoke),
            canGoNext: .constant(false)
        )
    }
}
