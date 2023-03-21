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

    private let buttonTextColor = Color.blue
    private let buttonBackgroundColor = Color.white

    var body: some View {
        HStack {
            /*
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
             Text("Back")
             .font(.headline)
             .foregroundColor(buttonTextColor)
             .frame(maxWidth: .infinity)
             }
             .opacity(index > 0 ? 1 : 0)
             */
            if index == questions.count - 1 {
                Button(action: {
                    event = .submit
                }) {
                    Text("Submit Survey")
                        .font(.headline)
                        .foregroundColor(buttonTextColor)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(buttonBackgroundColor)
                .cornerRadius(10)
                .padding(.horizontal)
            }

            if index < questions.count - 1 {
                Button(action: {
                    event = .next
                    withAnimation {
                        index = (index + 1) % questions.count
                        isAnimating = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation {
                            isAnimating = false
                        }
                    }

                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(buttonTextColor)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(buttonBackgroundColor)

                        )
                }
                .opacity(questions.isEmpty || index >= (questions.count - 1) ? 0 : 1)
            }
        }
    }
}

struct SurveyNavigationFooterView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyNavigationFooterView(
            questions: [SurveyQuestion(), SurveyQuestion()],
            index: .constant(0),
            isAnimating: .constant(false),
            event: .constant(.invoke))
    }
}
