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

    private let buttonTextColor = Color.white
    private let buttonBackgroundColor = Color.blue

    var body: some View {
        HStack {
            Button(action: {

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

            Button(action: {
                // surveyService.submitSurvey()
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

            Button(action: {

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
            }
            .opacity(questions.isEmpty || index >= (questions.count - 1) ? 0 : 1)
        }
    }
}
