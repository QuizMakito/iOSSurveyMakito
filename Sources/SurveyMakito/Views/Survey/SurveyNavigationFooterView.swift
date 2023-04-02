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
    var shouldEnableNextButton = false
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
                    if !shouldEnableNextButton{return}
                    
                    event = .submit
                }) {
                    buttonView(label: "Submit Survey")
                }
                .padding()
                .background(buttonBackgroundColor)
                .cornerRadius(10)
                .padding(.horizontal)
            }

            if index < questions.count - 1 {
                Button(action: {
                    if !shouldEnableNextButton{return}
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
                    buttonView(label: "Next")
                }
                .opacity(questions.isEmpty || index >= (questions.count - 1) ? 0 : 1)
            }
        }
    }

    func buttonView(label: String) -> some View {
        Text(label)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .frame(minWidth: 200, maxWidth: .infinity, minHeight: 40)
                    .foregroundColor(.blue)
                    .padding(10)
            )
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
