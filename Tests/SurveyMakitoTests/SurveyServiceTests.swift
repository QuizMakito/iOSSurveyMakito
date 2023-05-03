//
//  SurveyServiceTests.swift
//
//
//  Created by Kris Steigerwald on 3/17/23.
//

import XCTest
import FirebaseFirestore
@testable import SurveyMakito

final class SurveyServiceTests: XCTestCase {
    let service: SurveyService = SurveyService()

    func testSurveyResponse() {
        let aResponse = Uids.a.response
        let bResponse = Uids.b.response

        // Test adding a single response
        try? service.addResponse(response: aResponse)
        XCTAssertEqual(service.responses.count, 1)
        XCTAssertEqual(service.responses[aResponse.questionId]?.uid, aResponse.uid)

        // Test adding another response for the same survey
        try? service.addResponse(response: bResponse)
        XCTAssertEqual(service.responses.count, 2)
        XCTAssertEqual(service.responses[bResponse.questionId]?.uid, bResponse.uid)

        // Test updating an existing response
        let updatedAResponse = SurveyResponse(
            uid: Uids.a.rawValue,
            questionId: Uids.a.response.questionId,
            type: .multipleChoiceQuestion,
            values: [
                Uids.b.rawValue: Failable(uid: UUID().uuidString, value: "Purple"),
                UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue")
            ]
        )

        try? service.addResponse(response: updatedAResponse)
        XCTAssertEqual(service.responses.count, 2)
        XCTAssertEqual(service.responses[aResponse.questionId]?.values.count, 2)
        XCTAssertEqual(service.responses[aResponse.questionId]?.values[Uids.b.rawValue]?.value, "Purple")

        let reOccuringQuestion = service.responses[aResponse.questionId]
        let items = service.getMultipleChoiceResponses(from: reOccuringQuestion!)
        XCTAssertEqual(items.count, 2)
    }

    func testGetMultiChoice() {
        let aResponse = Uids.a.response
        let bResponse = Uids.d.response

        // Test adding a single response
        try? service.addResponse(response: aResponse)

        // Test adding another response for the same survey
        try? service.addResponse(response: bResponse)

        let reOccuringQuestion = service.responses[aResponse.questionId]
        let items = service.getMultipleChoiceResponses(from: reOccuringQuestion!)
        XCTAssertEqual(items.count, 2)

        let bQuestion = service.responses[bResponse.questionId]
        let bItems = service.getMultipleChoiceResponses(from: bQuestion!)
        XCTAssertEqual(bItems.count, 3)
    }

    func testLookUpQuiz() {
        let aResponse = Uids.a.response
        let bResponse = Uids.b.response

        // Test adding a single response
        try? service.addResponse(response: aResponse)
        try? service.addResponse(response: bResponse)

        XCTAssertEqual(service.responses.isEmpty, false)
    }

    func testContactForm() {
        let key = Uids.i.response.questionId
        let response = Uids.i.response
        let valueKey = Uids.s.rawValue
        try? service.addResponse(response: response)
        XCTAssertEqual(service.responses.count, 1)
        XCTAssertEqual(service.responses[key]!.questionId, key)
        XCTAssertEqual(service.responses[key]!.values[valueKey]?.value, "johndoe@example.com")
    }

    func testCommentsForm() {
        let key = Uids.o.response.questionId
        let response = Uids.o.response
        let valueKey = Uids.m.rawValue
        try? service.addResponse(response: response)
        XCTAssertEqual(service.responses.count, 1)
        XCTAssertEqual(service.responses[key]!.questionId, key)
        XCTAssertEqual(service.responses[key]!.values[valueKey]?.value, "Keep up the good work!")
    }

}

enum Uids: String {
    case a = "866B24FE-3DEF-4BEE-88AA-4249E170C615"
    case b = "9E528BA6-7D1F-4D6F-B76A-FFB819BA0488"
    case c = "3408F347-656A-4A32-86C1-DC0EB95319EE"
    case d = "6B53AED3-4DB2-44E5-8CE7-CB7CBBEA521F"
    case e = "16520D99-AE76-490C-A58E-9DF9732339D0"
    case f = "F8523C56-688E-4ACB-9CB5-323BA2F6D6D5"
    case g = "3003C6B2-66AC-4E54-A0CF-8057B4FDA7FA"
    case h = "33D914D1-8841-4C1C-A1B5-182704F77338"
    case i = "C6B5E8AA-FF6A-4EE6-836E-307D6D8CAC8A"
    case j = "7E80F45F-7D9E-4E8A-8AE9-A2FD7D221314"
    case k = "AC6D257D-8A37-41EE-85DD-228266EA54B3"
    case l = "6D82EF30-A418-45D4-9455-67AE8B73DAEB"
    case m = "9AD2A95C-4F0B-4EA0-BEE8-D65471E71546"
    case n = "8A7A446D-39BF-4CA1-B008-5E68395D60C4"
    case o = "F8DF7CC0-7F0A-42C2-9DB4-FBE684B71184"
    case p = "0ABFBF19-725D-4406-9A7B-358C4F752648"
    case q = "C29BC609-B350-4B2A-8A6D-147A59105316"
    case r = "1CA815EC-9901-47B9-A9A5-4AA38A939E5B"
    case s = "734A0D30-33AE-43A5-9496-8290ACA61681"

    var response: SurveyResponse {
        switch self {
        case .a: return SurveyResponse(uid: Uids.a.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .multipleChoiceQuestion, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Red"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue")
                                       ])
        case .b: return SurveyResponse(uid: Uids.b.rawValue,
                                       questionId: SurveyView.survey.questions![1].uid,
                                       type: .multipleChoiceQuestion, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Black"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Orange")
                                       ])
        case .c:
            return SurveyResponse(uid: Uids.c.rawValue,
                                  questionId: SurveyView.survey.questions![0].uid,
                                  type: .inlineQuestionGroup, values: [
                                    UUID().uuidString: Failable(uid: UUID().uuidString, value: "Example Text Input Response")
                                  ])
        case .d:
            return SurveyResponse(uid: Uids.d.rawValue,
                                  questionId: SurveyView.survey.questions![4].uid,
                                  type: .multipleChoiceQuestion, values: [
                                    UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option A"),
                                    UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option B"),
                                    UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option C")
                                  ])
        case .e:
            return SurveyResponse(uid: Uids.e.rawValue,
                                  questionId: SurveyView.survey.questions![0].uid,
                                  type: .binaryChoice, values: [
                                    UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option A")
                                  ])
        case .h: return SurveyResponse(uid: Uids.h.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .binaryChoice, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "No")
                                       ])

        case .i: return SurveyResponse(uid: Uids.i.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .contactForm, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "John"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Doe"),
                                        Uids.s.rawValue: Failable(uid: UUID().uuidString, value: "johndoe@example.com"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "1234567890")
                                       ])

        case .j: return SurveyResponse(uid: Uids.j.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .inlineQuestionGroup, values: [
                                        Uids.a.rawValue: Failable(uid: UUID().uuidString, value: "Red"),
                                        Uids.b.rawValue: Failable(uid: UUID().uuidString, value: "Black")
                                       ])

        case .k: return SurveyResponse(uid: Uids.k.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .commentsForm, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Great product!")
                                       ])

        case .l: return SurveyResponse(uid: Uids.l.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .multipleChoiceQuestion, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Red"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Green"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Black"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "White")
                                       ])

        case .m: return SurveyResponse(uid: Uids.m.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .binaryChoice, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "No")
                                       ])

        case .n: return SurveyResponse(uid: Uids.n.rawValue,
                                       questionId: SurveyView.survey.questions![2].uid,
                                       type: .inlineQuestionGroup, values: [
                                        Uids.a.rawValue: Failable(uid: UUID().uuidString, value: "Red"),
                                        Uids.b.rawValue: Failable(uid: UUID().uuidString, value: "Black"),
                                        Uids.c.rawValue: Failable(uid: UUID().uuidString, value: "Green")
                                       ])

        case .o: return SurveyResponse(uid: Uids.o.rawValue,
                                       questionId: SurveyView.survey.questions![3].uid,
                                       type: .commentsForm, values: [
                                        Uids.m.rawValue: Failable(uid: UUID().uuidString, value: "Keep up the good work!")
                                       ])

        case .p: return SurveyResponse(uid: Uids.p.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .multipleChoiceQuestion, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Android"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "iOS"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Windows"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "MacOS")
                                       ])

        default: return SurveyResponse(uid: Uids.a.rawValue,
                                       questionId: SurveyView.survey.questions![0].uid,
                                       type: .multipleChoiceQuestion, values: [
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Red"),
                                        UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue")
                                       ])
        }
    }
}

public extension SurveyView {

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
                            MultipleChoiceResponse(uid: "B80E2036-9872-4570-91B1-176EC3CE394F", text: "Red"),
                            MultipleChoiceResponse(uid: "8C3DF48E-8900-439C-940D-345CB50C30BD", text: "Blue"),
                            MultipleChoiceResponse(uid: "294BBC0E-DD1B-4F2F-8539-D2D13A42E804", text: "Green")
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
                        MultipleChoiceResponse(uid: "62160F21-5B8C-4381-A334-5422FFCFE09F", text: "Yes"),
                        MultipleChoiceResponse(uid: "D37A3FAF-B4C7-44A2-B7E1-DCAD2AD0B2B0", text: "No")
                    ],
                    autoAdvanceOnChoice: true
                )
            ),
            SurveyQuestion(
                uid: "400D99D6-1F52-466F-B024-D38961E5384B",
                title: "On a scale of 1 to 10, how satisfied are you with our product?",
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
                            MultipleChoiceResponse(uid: "8FAC5617-746D-456A-B946-0B4BF63061B8", text: "5"),
                            MultipleChoiceResponse(uid: "6EDB2D11-8729-4575-A8B4-ABA6E71DA30D", text: "6"),
                            MultipleChoiceResponse(uid: "2182E7A4-9CE0-4588-8D59-C2181EAB332D", text: "7"),
                            MultipleChoiceResponse(uid: "66C5F3AB-03CB-4091-8F75-0C696E995149", text: "8"),
                            MultipleChoiceResponse(uid: "C3709F83-9765-4DF4-9463-03F15DB7EC4F", text: "9"),
                            MultipleChoiceResponse(uid: "EEA5D02A-EBA4-49E0-8584-F3D6E102B39A", text: "10")
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
                        MultipleChoiceResponse(uid: "4F2E95E4-3A75-41DE-AADD-78B2980A1396", text: "18-24"),
                        MultipleChoiceResponse(uid: "8E2CFDA1-9E31-44DE-A135-6CDB4E390E10", text: "25-34"),
                        MultipleChoiceResponse(uid: "AA3D9E78-FD34-45A4-B7BA-AEBC1D51E10C", text: "35-44"),
                        MultipleChoiceResponse(uid: "194E55AC-C962-4BC3-9DD0-EE99AC32BE49", text: "45-54"),
                        MultipleChoiceResponse(uid: "F6FD5EEB-E3D3-4E0B-8FD5-A9D53C0C5D2F", text: "55-64"),
                        MultipleChoiceResponse(uid: "74E881DD-CD9A-476F-9660-AECEC0951BD2", text: "65+")
                    ],
                    allowsMultipleSelection: false
                )]
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
}
