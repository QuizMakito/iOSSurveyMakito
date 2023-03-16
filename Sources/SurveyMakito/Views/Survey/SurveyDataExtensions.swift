//
//  SwiftUIView.swift
//
//
//  Created by Kris Steigerwald on 3/16/23.
//

import SwiftUI

public extension SurveyView {
    static var multipleChoiceQuestion1 = MultipleChoiceQuestion(
        uid: "A7739A62-035D-4708-9D1B-1CBA2E6795DF",
        choices: [
            MultipleChoiceResponse(uid: "001a", text: "Option A"),
            MultipleChoiceResponse(uid: "001b", text: "Option B"),
            MultipleChoiceResponse(uid: "001c", text: "Option C")
        ],
        allowsMultipleSelection: false
    )

    static var binaryQuestion1 = BinaryQuestion(
        uid: "A09730CC-3957-47D6-BDF6-D5BAB8E0DC26",
        choices: [
            MultipleChoiceResponse(uid: "002a", text: "Yes"),
            MultipleChoiceResponse(uid: "002b", text: "No")
        ],
        allowsMultipleSelection: false,
        autoAdvanceOnChoice: true
    )

    static var contactFormQuestion1 = ContactFormQuestion(
        uid: "AE9F1EA4-A891-4ECD-9D13-A0BF0A266158",
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
        uid: "FCB6FF1B-3044-40AB-833F-B084BA93E6A3",
        choices: [
            MultipleChoiceResponse(uid: "68E437D2-717A-447F-B19B-ED211A41685E", text: "Option A"),
            MultipleChoiceResponse(uid: "FF7DB6A5-AB70-4EE8-98EC-F5A821D374F7", text: "Option B"),
            MultipleChoiceResponse(uid: "695064DA-A556-45C2-B84D-05626660F12F", text: "Option C")
        ],
        allowsMultipleSelection: true,
        questions: [
            MultipleChoiceQuestion(
                uid: "004a",
                choices: [
                    MultipleChoiceResponse(uid: "7846283D-CD14-45C6-93F2-A389C8866763", text: "Option A1"),
                    MultipleChoiceResponse(uid: "CAAF89ED-9B6F-4F4E-A38B-C4376B63CEBF", text: "Option A2"),
                    MultipleChoiceResponse(uid: "8B481B48-476F-4D90-9114-2F24D24EFA8C", text: "Option A3")
                ],
                allowsMultipleSelection: true
            ),
            MultipleChoiceQuestion(
                uid: "004b",
                choices: [
                    MultipleChoiceResponse(uid: "C610E98E-BFE6-4A2B-9F4B-B8E92CA60E64", text: "Option B1"),
                    MultipleChoiceResponse(uid: "CBFC8613-1CF8-4655-BBF0-C7839FB5F503", text: "Option B2"),
                    MultipleChoiceResponse(uid: "E95BF23F-E2D5-438F-869A-B3AD34D9FD51", text: "Option B3")
                ],
                allowsMultipleSelection: false
            )
        ]
    )

    static var commentsFormQuestion1 = CommentsFormQuestion(
        uid: "2DD1B60B-B836-4669-BEA8-20853BE70ACD",
        required: false,
        choices: [
            MultipleChoiceResponse(uid: "3E555BC8-FD84-45A7-875C-82627AED783C", text: "Yes"),
            MultipleChoiceResponse(uid: "E8D377D0-B368-413F-8F7F-E8D4C01085D8", text: "No")
        ],
        allowsMultipleSelection: false,
        feedback: "This is some feedback."
    )

    // Survey

    static var survey = Survey(
        uid: "5D153C45-16E5-4786-9AB5-9398B75EF98E",
        questions: [
            SurveyQuestion(
                uid: "D0A06630-056C-4B6E-B61C-E74B679162B1",
                title: "What's your favorite color?",
                tag: "color",
                type: .multipleChoiceQuestion,
                multipleChoice: [
                    MultipleChoiceQuestion(
                        uid: "00797664-3682-4112-B48E-616D2CBEA5E2",
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
                uid: "5395DA84-6198-49AD-8BB8-9C10C0EB403B",
                title: "How often do you exercise?",
                tag: "exercise",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "4BCC4341-7743-41AB-B761-CEF3F7E331AE",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "yes", text: "Yes"),
                        MultipleChoiceResponse(uid: "no", text: "No")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "400D99D6-1F52-466F-B024-D38961E5384B",
                title: "On a scale of 1 to 10, how satisfied are you with our product?",
                tag: "satisfaction",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "D5154185-F7BB-4989-95DB-3F864705C41F",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "22922676-8A4A-47F6-BBF4-6AA5381F63BF", text: "1"),
                        MultipleChoiceResponse(uid: "46325376-383F-48CB-890F-A22D5F890F88", text: "2"),
                        MultipleChoiceResponse(uid: "6A45189D-41DE-48AA-9E55-46302F02DFBD", text: "3"),
                        MultipleChoiceResponse(uid: "41B5FB6E-B252-47E7-A36C-D124142BF1D0", text: "4"),
                        MultipleChoiceResponse(uid: "8FAC5617-746D-456A-B946-0B4BF63061B8", text: "5"),
                        MultipleChoiceResponse(uid: "6EDB2D11-8729-4575-A8B4-ABA6E71DA30D", text: "6"),
                        MultipleChoiceResponse(uid: "2182E7A4-9CE0-4588-8D59-C2181EAB332D", text: "7"),
                        MultipleChoiceResponse(uid: "66C5F3AB-03CB-4091-8F75-0C696E995149", text: "8"),
                        MultipleChoiceResponse(uid: "C3709F83-9765-4DF4-9463-03F15DB7EC4F", text: "9"),
                        MultipleChoiceResponse(uid: "EEA5D02A-EBA4-49E0-8584-F3D6E102B39A", text: "10")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "4213F4C5-FAAD-409C-A97A-1D94B4C4134D",
                title: "What's your age range?",
                tag: "age",
                type: .inlineQuestionGroup,
                inlineMultipleChoice: InlineMultipleChoiceQuestionGroup(
                    uid: "FDA1C732-5E02-4001-BE0A-F72584823BE1",
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
                uid: "09E81040-B2C6-4EA7-9D27-CFF0395E6D63",
                title: "How would you rate your experience with our app?",
                tag: "rating",
                type: .contactForm,
                contactFormQuestion: ContactFormQuestion(
                    uid: "B8711AC1-28E6-471C-9D7A-588F70B2AF87",
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
                uid: "C46868A9-580D-4537-822D-540CAF6619E1",
                title: "What do you think of our app?",
                type: .commentsForm,
                commentsFormQuetion: CommentsFormQuestion(
                    uid: "A8ECA90D-0368-4041-B8B9-BC7766C3A524",
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
        uid: "5D153C45-16E5-4786-9AB5-9398B75EF98E",
        questions: [
            SurveyQuestion(
                uid: "D0A06630-056C-4B6E-B61C-E74B679162B1",
                title: "What's your favorite color?",
                tag: "color",
                type: .multipleChoiceQuestion,
                multipleChoice: [
                    MultipleChoiceQuestion(
                        uid: "00797664-3682-4112-B48E-616D2CBEA5E2",
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
                uid: "5395DA84-6198-49AD-8BB8-9C10C0EB403B",
                title: "How often do you exercise?",
                tag: "exercise",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "4BCC4341-7743-41AB-B761-CEF3F7E331AE",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "yes", text: "Yes"),
                        MultipleChoiceResponse(uid: "no", text: "No")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "400D99D6-1F52-466F-B024-D38961E5384B",
                title: "On a scale of 1 to 10, how satisfied are you with our product?",
                tag: "satisfaction",
                type: .binaryChoice,
                binaryQuestion: BinaryQuestion(
                    uid: "D5154185-F7BB-4989-95DB-3F864705C41F",
                    required: true,
                    choices: [
                        MultipleChoiceResponse(uid: "22922676-8A4A-47F6-BBF4-6AA5381F63BF", text: "1"),
                        MultipleChoiceResponse(uid: "46325376-383F-48CB-890F-A22D5F890F88", text: "2"),
                        MultipleChoiceResponse(uid: "6A45189D-41DE-48AA-9E55-46302F02DFBD", text: "3"),
                        MultipleChoiceResponse(uid: "41B5FB6E-B252-47E7-A36C-D124142BF1D0", text: "4"),
                        MultipleChoiceResponse(uid: "8FAC5617-746D-456A-B946-0B4BF63061B8", text: "5"),
                        MultipleChoiceResponse(uid: "6EDB2D11-8729-4575-A8B4-ABA6E71DA30D", text: "6"),
                        MultipleChoiceResponse(uid: "2182E7A4-9CE0-4588-8D59-C2181EAB332D", text: "7"),
                        MultipleChoiceResponse(uid: "66C5F3AB-03CB-4091-8F75-0C696E995149", text: "8"),
                        MultipleChoiceResponse(uid: "C3709F83-9765-4DF4-9463-03F15DB7EC4F", text: "9"),
                        MultipleChoiceResponse(uid: "EEA5D02A-EBA4-49E0-8584-F3D6E102B39A", text: "10")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "4213F4C5-FAAD-409C-A97A-1D94B4C4134D",
                title: "What's your age range?",
                tag: "age",
                type: .inlineQuestionGroup,
                inlineMultipleChoice: InlineMultipleChoiceQuestionGroup(
                    uid: "FDA1C732-5E02-4001-BE0A-F72584823BE1",
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
                uid: "09E81040-B2C6-4EA7-9D27-CFF0395E6D63",
                title: "How would you rate your experience with our app?",
                tag: "rating",
                type: .contactForm,
                contactFormQuestion: ContactFormQuestion(
                    uid: "B8711AC1-28E6-471C-9D7A-588F70B2AF87",
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
                uid: "C46868A9-580D-4537-822D-540CAF6619E1",
                title: "What do you think of our app?",
                type: .commentsForm,
                commentsFormQuetion: CommentsFormQuestion(
                    uid: "A8ECA90D-0368-4041-B8B9-BC7766C3A524",
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
