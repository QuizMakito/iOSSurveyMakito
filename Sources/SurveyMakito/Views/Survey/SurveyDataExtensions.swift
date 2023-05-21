//
//  SwiftUIView.swift
//
//
//  Created by Kris Steigerwald on 3/16/23.
//

import SwiftUI

extension PreviewStruct {
    static var survey = Survey(
        uid: "5D153C45-16E5-4786-9AB5-9398B75EF98E",
        questions: [
            SurveyQuestion(
                uid: "D0A06630-056C-4B6E-B61C-E74B679162B1",
                title: "Which of the following features would you like to use in our app?",
                tag: "color",
                type: .multipleChoiceQuestion,
                multipleChoice: [
                    MultipleChoiceQuestion(
                        uid: "00797664-3682-4112-B48E-616D2CBEA5E2",
                        choices: [
                            MultipleChoiceResponse(uid: "B80E2036-9872-4570-91B1-176EC3CE394F", text: "Flash Cards"),
                            MultipleChoiceResponse(uid: "8C3DF48E-8900-439C-940D-345CB50C30BD", text: "More games"),
                            MultipleChoiceResponse(uid: "294BBC0E-DD1B-4F2F-8539-D2D13A42E804", text: "Leaderboards"),
                            MultipleChoiceResponse(uid: "D74AA244-8159-42A0-A6A3-5F36CA60005D", text: "Play quizzes with friends"),
                            MultipleChoiceResponse(uid: "D74AA244-8159-42A0-A6A3-5F36CA60035D", text: "Other", allowCustomTextEntry: true, customTextEntry: "")
                        ],
                        allowsMultipleSelection: true
                    )
                ]
            ),
            SurveyQuestion(
                uid: "400D99D6-1F52-466F-B024-D38961E5384B",
                title: "On a scale of 1 to 5, how satisfied are you with our product?",
                tag: "satisfaction",
                type: .multipleChoiceQuestion,
                multipleChoice: [
                    MultipleChoiceQuestion(
                        uid: "D5154185-F7BB-4989-95DB-3F864705C41F",
                        choices: [
                            MultipleChoiceResponse(uid: "22922676-8A4A-47F6-BBF4-6AA5381F63BF", text: "1"),
                            MultipleChoiceResponse(uid: "46325376-383F-48CB-890F-A22D5F890F88", text: "2"),
                            MultipleChoiceResponse(uid: "6A45189D-41DE-48AA-9E55-46302F02DFBD", text: "3"),
                            MultipleChoiceResponse(uid: "41B5FB6E-B252-47E7-A36C-D124142BF1D0", text: "4"),
                            MultipleChoiceResponse(uid: "8FAC5617-746D-456A-B946-0B4BF63061B8", text: "5")
                        ],
                        allowsMultipleSelection: false,
                        autoAdvanceOnChoice: true
                    )]
            ),
            SurveyQuestion(
                uid: "4213F4C5-FAAD-409C-A97A-1D94B4C4134D",
                title: "What's your age range?",
                tag: "age",
                type: .multipleChoiceQuestion,
                multipleChoice: [MultipleChoiceQuestion(
                    uid: "FDA1C732-5E02-4001-BE0A-F72584823BE1",
                    choices: [
                        MultipleChoiceResponse(uid: "21125EF8-4E78-428E-A061-4E054E938AD5", text: "10 and below"),
                        MultipleChoiceResponse(uid: "83F20354-99E7-4E2F-AED3-D7414D2F294E", text: "11-26"),
                        MultipleChoiceResponse(uid: "4F2E95E4-3A75-41DE-AADD-78B2980A1396", text: "27-42"),
                        MultipleChoiceResponse(uid: "8E2CFDA1-9E31-44DE-A135-6CDB4E390E10", text: "43-58"),
                        MultipleChoiceResponse(uid: "AA3D9E78-FD34-45A4-B7BA-AEBC1D51E10C", text: "59 and above")
                    ],
                    allowsMultipleSelection: false
                )]
            ),
            SurveyQuestion(
                uid: "09E81040-B2C6-4EA7-9D27-CFF0395E6D63",
                title: "For 15 Free Makito Tokens, signup for our news letter!",
                tag: "rating",
                type: .contactForm,
                isRequired: false,
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
            )
        ])

    static var preview: PreviewStruct {
        return PreviewStruct(index: 0, survey: survey)
    }

}
