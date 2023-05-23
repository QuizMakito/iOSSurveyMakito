//
//  SurveyTests.swift
//
//
//  Created by Kris Steigerwald on 3/17/23.
//

import XCTest
import FirebaseFirestore
@testable import SurveyMakito

final class SurveyTests: XCTestCase {
    // Survey Questions
    let multipleChoiceQuestion1 = MultipleChoiceQuestion(
        uid: "001",
        choices: [
            MultipleChoiceResponse(uid: "001a", text: "Option A"),
            MultipleChoiceResponse(uid: "001b", text: "Option B"),
            MultipleChoiceResponse(uid: "001c", text: "Option C")
        ],
        allowsMultipleSelection: false
    )

    let binaryQuestion1 = BinaryQuestion(
        uid: "002",
        choices: [
            MultipleChoiceResponse(uid: "002a", text: "Yes"),
            MultipleChoiceResponse(uid: "002b", text: "No")
        ],
        allowsMultipleSelection: false,
        autoAdvanceOnChoice: true
    )

    let contactFormQuestion1 = ContactFormQuestion(
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

//    let inlineMultipleChoiceQuestionGroup1 = InlineMultipleChoiceQuestionGroup(
//        uid: "004",
//        choices: [
//            InlineChoiceResponse(uid: "004a", text: "Option A"),
//            InlineChoiceResponse(uid: "004b", text: "Option B"),
//            InlineChoiceResponse(uid: "004c", text: "Option C")
//        ],
//        allowsMultipleSelection: true,
//        questions: [
//            InlineChoiceQuestion(
//                uid: "004a",
//                choices: [
//                    InlineChoiceResponse(uid: "004aa", text: "Option A1"),
//                    InlineChoiceResponse(uid: "004ab", text: "Option A2"),
//                    InlineChoiceResponse(uid: "004ac", text: "Option A3")
//                ]
//            ),
//            InlineChoiceQuestion(
//                uid: "004b",
//                choices: [
//                    InlineChoiceResponse(uid: "004ba", text: "Option B1"),
//                    InlineChoiceResponse(uid: "004bb", text: "Option B2"),
//                    InlineChoiceResponse(uid: "004bc", text: "Option B3")
//                ]
//            )
//        ]
//    )

    let commentsFormQuestion1 = CommentsFormQuestion(
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
    let survey = Survey(
        uid: "abcd-1234",
        questions: [
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
//            SurveyQuestion(
//                uid: "q3",
//                title: "What's your age range?",
//                tag: "age",
//                type: .inlineQuestionGroup,
//                inlineMultipleChoice: InlineMultipleChoiceQuestionGroup(
//                    uid: "imc1",
//                    choices: [
//                        InlineChoiceResponse(uid: "18-24", text: "18-24"),
//                        InlineChoiceResponse(uid: "25-34", text: "25-34"),
//                        InlineChoiceResponse(uid: "35-44", text: "35-44"),
//                        InlineChoiceResponse(uid: "45-54", text: "45-54"),
//                        InlineChoiceResponse(uid: "55-64", text: "55-64"),
//                        InlineChoiceResponse(uid: "65+", text: "65+")
//                    ],
//                    questions: [
//                        InlineChoiceQuestion(
//                            uid: "mc2",
//                            choices: [
//                                InlineChoiceResponse(uid: "male", text: "Male"),
//                                InlineChoiceResponse(uid: "female", text: "Female"),
//                                InlineChoiceResponse(uid: "nonbinary", text: "Non-binary")
//                            ]
//                        )
//                    ]
//                )
//            ),
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

    func testSurveyEncodingAndDecoding() {
        let expectedSurvey = Survey(id: "123", uid: "456", questions: [
            SurveyQuestion(uid: "777", title: "foo bar", tag: "tagit")
        ])
        let encoder = Firestore.Encoder()
        let decoder = Firestore.Decoder()

        do {
            let data = try encoder.encode(expectedSurvey)
            let decodedSurvey = try decoder.decode(Survey.self, from: data)
            XCTAssertEqual(expectedSurvey.uid, decodedSurvey.uid)
        } catch {
            XCTFail("Encoding or decoding of Survey struct failed with error: \(error)")
        }
    }
}
