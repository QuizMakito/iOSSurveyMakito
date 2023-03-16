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

    public var body: some View {
        SurveyWrap(color: .blue) {
            ScrollView {
                LazyVStack(spacing: 20) {
                    if let questions = survey.questions {
                        if let question = questions[index] {
                            switch question.type {
                            case .binaryChoice:
                                BinaryQuestionView(question: question)
                            case .multipleChoiceQuestion:
                                MultipleChoiceQuestionView(question: question)
                            case .inlineQuestionGroup:
                                // let mcg = InlineMultipleChoiceQuestionGroup()
                                InlineMultipleChoiceQuestionGroupView(question: question)
                            case .contactForm:
                                ContactFormQuestionView(question: question)
                            case .commentsForm:
                                CommentsFormQuestionView(question: question)
                            default:
                                EmptyView()
                            }
                        }
                    }
                }
                .padding()
            }
        } footer: {
            HStack {
                if index > 0 {
                    Button(action: {
                        index -= 1
                    }, label: {
                        Text("back")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    })
                } else {
                    Spacer()
                }

                Button(action: {
                    // surveyService.submitSurvey()
                }) {
                    Text("Submit Survey")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                if let questions = survey.questions {
                    if index < (questions.count - 1) {
                        Button(action: {
                            index += 1
                        }, label: {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        })
                    }
                } else {
                    Spacer()
                }

            }
        }
        .navigationBarTitle("Survey", displayMode: .inline)
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
                        ]
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
                        ]
                    )
                ]
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
                        ]
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
                        ]
                    )
                ]
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
