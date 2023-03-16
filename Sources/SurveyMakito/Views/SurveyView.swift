//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI
import Combine

struct PreviewStruct: View {

    @State var index: Int = 0
    @State public var survey: Survey

    var body: some View {
        VStack {
            SurveyView(survey: $survey, index: $index)
        }
        .onChange(of: index, perform: { val in
            print(val)
        })
    }
}

public struct SurveyView: View {
    @Namespace private var namespace
    @State private var isAnimating = false
    @State public var surveyService: SurveyService
    @Binding public var survey: Survey
    @Binding public var index: Int

    public init(
        surveyService: SurveyService = SurveyService(),
        survey: Binding<Survey>,
        index: Binding<Int>
    ) {
        self.surveyService = surveyService
        self._survey = survey
        self._index = index
    }

    func switchView(question: SurveyQuestion) -> some View {
        switch question.type {
        case .binaryChoice:
            return AnyView(BinaryQuestionView(question: question))
        case .multipleChoiceQuestion:
            return AnyView(MultipleChoiceQuestionView(question: question))
        case .inlineQuestionGroup:
            return AnyView(InlineMultipleChoiceQuestionGroupView(question: question))
        case .contactForm:
            return AnyView(ContactFormQuestionView(question: question))
        case .commentsForm:
            return AnyView(CommentsFormQuestionView(question: question))
        default:
            return AnyView(EmptyView())
        }
    }

    func stackToAnim(questions: [SurveyQuestion]) -> some View {
        AnyView(
            LazyVStack(spacing: 20) {
                if let questions = survey.questions {
                    if let question = questions[index] {
                        switchView(question: question)
                    }
                }
            }.padding()
        )
    }

    public var body: some View {
        SurveyWrap(color: .gray) {
            ScrollView {
                if isAnimating {
                    if let questions = survey.questions {
                        stackToAnim(questions: questions)
                            .matchedGeometryEffect(id: "survey", in: namespace)
                    }
                } else {
                    if let questions = survey.questions {
                        stackToAnim(questions: questions)
                            .matchedGeometryEffect(id: "survey", in: namespace)
                    }
                }
            }
        } footer: {
            HStack {
                if let questions = survey.questions {
                    SurveyNavigationFooterView(questions: questions, index: $index, isAnimating: $isAnimating)

                }
            }
        }
        .navigationBarTitle("Survey", displayMode: .inline)
    }
}

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

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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

public extension SurveyView {
    static var multipleChoiceQuestion1 = MultipleChoiceQuestion(
        uid: "001",
        choices: [
            MultipleChoiceResponse(uid: "001a", text: "Option A"),
            MultipleChoiceResponse(uid: "001b", text: "Option B"),
            MultipleChoiceResponse(uid: "001c", text: "Option C")
        ],
        allowsMultipleSelection: false
    )

    static var binaryQuestion1 = BinaryQuestion(
        uid: "002",
        choices: [
            MultipleChoiceResponse(uid: "002a", text: "Yes"),
            MultipleChoiceResponse(uid: "002b", text: "No")
        ],
        allowsMultipleSelection: false,
        autoAdvanceOnChoice: true
    )

    static var contactFormQuestion1 = ContactFormQuestion(
        uid: "003",
        required: true,
        choices: [
            MultipleChoiceResponse(uid: "003a", text: "I need help with the app"),
            MultipleChoiceResponse(uid: "003b", text: "I have a general question"),
            MultipleChoiceResponse(uid: "003c", text: "I have feedback"),
            MultipleChoiceResponse(uid: "003d", text: "Other")
        ],
        emailAddress: "example@example.com",
        name: "John Doe",
        company: "Example Co.",
        phoneNumber: "+1 (555) 555-5555",
        feedback: "This is some feedback."
    )

    static var inlineMultipleChoiceQuestionGroup1 = InlineMultipleChoiceQuestionGroup(
        uid: "004",
        choices: [
            MultipleChoiceResponse(uid: "004a", text: "Option A"),
            MultipleChoiceResponse(uid: "004b", text: "Option B"),
            MultipleChoiceResponse(uid: "004c", text: "Option C")
        ],
        allowsMultipleSelection: true,
        questions: [
            MultipleChoiceQuestion(
                uid: "004a",
                choices: [
                    MultipleChoiceResponse(uid: "004aa", text: "Option A1"),
                    MultipleChoiceResponse(uid: "004ab", text: "Option A2"),
                    MultipleChoiceResponse(uid: "004ac", text: "Option A3")
                ],
                allowsMultipleSelection: true
            ),
            MultipleChoiceQuestion(
                uid: "004b",
                choices: [
                    MultipleChoiceResponse(uid: "004ba", text: "Option B1"),
                    MultipleChoiceResponse(uid: "004bb", text: "Option B2"),
                    MultipleChoiceResponse(uid: "004bc", text: "Option B3")
                ],
                allowsMultipleSelection: false
            )
        ]
    )

    static var commentsFormQuestion1 = CommentsFormQuestion(
        uid: "005",
        required: false,
        choices: [
            MultipleChoiceResponse(uid: "005a", text: "Yes"),
            MultipleChoiceResponse(uid: "005b", text: "No")
        ],
        allowsMultipleSelection: false,
        feedback: "This is some feedback."
    )

    // Survey

    static var survey = Survey(
        uid: "abcd-1234",
        questions: [
            SurveyQuestion(
                uid: "q2",
                title: "What's your favorite color?",
                tag: "color",
                type: .multipleChoiceQuestion,
                multipleChoice: [
                    MultipleChoiceQuestion(
                        uid: "mc1",
                        choices: [
                            MultipleChoiceResponse(uid: "red", text: "Red"),
                            MultipleChoiceResponse(uid: "blue", text: "Blue"),
                            MultipleChoiceResponse(uid: "green", text: "Green")
                        ],
                        allowsMultipleSelection: true
                    )
                ]
            ),
            SurveyQuestion(
                uid: "q1",
                title: "How often do you exercise?",
                tag: "exercise",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "b1",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "yes", text: "Yes"),
                        MultipleChoiceResponse(uid: "no", text: "No")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "q1",
                title: "On a scale of 1 to 10, how satisfied are you with our product?",
                tag: "satisfaction",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "b1",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "1", text: "1"),
                        MultipleChoiceResponse(uid: "2", text: "2"),
                        MultipleChoiceResponse(uid: "3", text: "3"),
                        MultipleChoiceResponse(uid: "4", text: "4"),
                        MultipleChoiceResponse(uid: "5", text: "5"),
                        MultipleChoiceResponse(uid: "6", text: "6"),
                        MultipleChoiceResponse(uid: "7", text: "7"),
                        MultipleChoiceResponse(uid: "8", text: "8"),
                        MultipleChoiceResponse(uid: "9", text: "9"),
                        MultipleChoiceResponse(uid: "10", text: "10")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "q3",
                title: "What's your age range?",
                tag: "age",
                type: .inlineQuestionGroup,
                inlineMultipleChoice: InlineMultipleChoiceQuestionGroup(
                    uid: "imc1",
                    choices: [
                        MultipleChoiceResponse(uid: "18-24", text: "18-24"),
                        MultipleChoiceResponse(uid: "25-34", text: "25-34"),
                        MultipleChoiceResponse(uid: "35-44", text: "35-44"),
                        MultipleChoiceResponse(uid: "45-54", text: "45-54"),
                        MultipleChoiceResponse(uid: "55-64", text: "55-64"),
                        MultipleChoiceResponse(uid: "65+", text: "65+")
                    ],
                    questions: [
                        MultipleChoiceQuestion(
                            uid: "mc2",
                            choices: [
                                MultipleChoiceResponse(uid: "male", text: "Male"),
                                MultipleChoiceResponse(uid: "female", text: "Female"),
                                MultipleChoiceResponse(uid: "nonbinary", text: "Non-binary")
                            ],
                            allowsMultipleSelection: true
                        )
                    ]
                )
            ),
            SurveyQuestion(
                uid: "q4",
                title: "How would you rate your experience with our app?",
                tag: "rating",
                type: .contactForm,
                contactFormQuestion: ContactFormQuestion(
                    uid: "cf1",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "1", text: "Poor"),
                        MultipleChoiceResponse(uid: "2", text: "Fair"),
                        MultipleChoiceResponse(uid: "3", text: "Good"),
                        MultipleChoiceResponse(uid: "4", text: "Very Good"),
                        MultipleChoiceResponse(uid: "5", text: "Excellent")
                    ],
                    emailAddress: "user@example.com",
                    name: "John Doe",
                    company: "Example Corp",
                    phoneNumber: "555-555-5555",
                    feedback: "Optional feedback goes here."
                )
            ),
            SurveyQuestion(
                uid: "FEEDBACK_QUESTION",
                title: "What do you think of our app?",
                type: .commentsForm,
                commentsFormQuetion: CommentsFormQuestion(
                    uid: "FEEDBACK_QUESTION",
                    choices: [
                        MultipleChoiceResponse(uid: "EXCELLENT_RESPONSE", text: "Excellent"),
                        MultipleChoiceResponse(uid: "GOOD_RESPONSE", text: "Good"),
                        MultipleChoiceResponse(uid: "FAIR_RESPONSE", text: "Fair"),
                        MultipleChoiceResponse(uid: "POOR_RESPONSE", text: "Poor")
                    ],
                    allowsMultipleSelection: true,
                    emailAddress: "feedback@example.com"
                )
            )
        ])

    static var example: SurveyView {
        return SurveyView(survey: .constant(survey), index: .constant(0))
    }

}

extension PreviewStruct {
    static var survey = Survey(
        uid: "abcd-1234",
        questions: [
            SurveyQuestion(
                uid: "q2",
                title: "What's your favorite color?",
                tag: "color",
                type: .multipleChoiceQuestion,
                multipleChoice: [
                    MultipleChoiceQuestion(
                        uid: "mc1",
                        choices: [
                            MultipleChoiceResponse(uid: "red", text: "Red"),
                            MultipleChoiceResponse(uid: "blue", text: "Blue"),
                            MultipleChoiceResponse(uid: "green", text: "Green")
                        ],
                        allowsMultipleSelection: true
                    )
                ]
            ),
            SurveyQuestion(
                uid: "q1",
                title: "How often do you exercise?",
                tag: "exercise",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "b1",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "yes", text: "Yes"),
                        MultipleChoiceResponse(uid: "no", text: "No")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "q6",
                title: "On a scale of 1 to 10, how satisfied are you with our product?",
                tag: "satisfaction",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "b1",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "1", text: "1"),
                        MultipleChoiceResponse(uid: "2", text: "2"),
                        MultipleChoiceResponse(uid: "3", text: "3"),
                        MultipleChoiceResponse(uid: "4", text: "4"),
                        MultipleChoiceResponse(uid: "5", text: "5"),
                        MultipleChoiceResponse(uid: "6", text: "6"),
                        MultipleChoiceResponse(uid: "7", text: "7"),
                        MultipleChoiceResponse(uid: "8", text: "8"),
                        MultipleChoiceResponse(uid: "9", text: "9"),
                        MultipleChoiceResponse(uid: "10", text: "10")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "q3",
                title: "What's your age range?",
                tag: "age",
                type: .inlineQuestionGroup,
                inlineMultipleChoice: InlineMultipleChoiceQuestionGroup(
                    uid: "imc1",
                    choices: [
                        MultipleChoiceResponse(uid: "18-24", text: "18-24"),
                        MultipleChoiceResponse(uid: "25-34", text: "25-34"),
                        MultipleChoiceResponse(uid: "35-44", text: "35-44"),
                        MultipleChoiceResponse(uid: "45-54", text: "45-54"),
                        MultipleChoiceResponse(uid: "55-64", text: "55-64"),
                        MultipleChoiceResponse(uid: "65+", text: "65+")
                    ],
                    questions: [
                        MultipleChoiceQuestion(
                            uid: "mc2",
                            choices: [
                                MultipleChoiceResponse(uid: "male", text: "Male"),
                                MultipleChoiceResponse(uid: "female", text: "Female"),
                                MultipleChoiceResponse(uid: "nonbinary", text: "Non-binary")
                            ],
                            allowsMultipleSelection: true
                        )
                    ]
                )
            ),
            SurveyQuestion(
                uid: "q4",
                title: "How would you rate your experience with our app?",
                tag: "rating",
                type: .contactForm,
                contactFormQuestion: ContactFormQuestion(
                    uid: "cf1",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "1", text: "Poor"),
                        MultipleChoiceResponse(uid: "2", text: "Fair"),
                        MultipleChoiceResponse(uid: "3", text: "Good"),
                        MultipleChoiceResponse(uid: "4", text: "Very Good"),
                        MultipleChoiceResponse(uid: "5", text: "Excellent")
                    ],
                    emailAddress: "user@example.com",
                    name: "John Doe",
                    company: "Example Corp",
                    phoneNumber: "555-555-5555",
                    feedback: "Optional feedback goes here."
                )
            ),
            SurveyQuestion(
                uid: "FEEDBACK_QUESTION",
                title: "What do you think of our app?",
                type: .commentsForm,
                commentsFormQuetion: CommentsFormQuestion(
                    uid: "FEEDBACK_QUESTION",
                    choices: [
                        MultipleChoiceResponse(uid: "EXCELLENT_RESPONSE", text: "Excellent"),
                        MultipleChoiceResponse(uid: "GOOD_RESPONSE", text: "Good"),
                        MultipleChoiceResponse(uid: "FAIR_RESPONSE", text: "Fair"),
                        MultipleChoiceResponse(uid: "POOR_RESPONSE", text: "Poor")
                    ],
                    allowsMultipleSelection: true,
                    emailAddress: "feedback@example.com"
                )
            )
        ])

    static var preview: PreviewStruct {
        return PreviewStruct(index: 0, survey: survey)
    }

}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewStruct.preview
            .environmentObject(SurveyService())
    }
}
