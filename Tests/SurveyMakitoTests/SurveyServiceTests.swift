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
        service.addResponse(response: aResponse)
        XCTAssertEqual(service.responses.count, 1)
        XCTAssertEqual(service.responses[aResponse.uid]?.uid, aResponse.uid)

        // Test adding another response for the same survey
        service.addResponse(response: bResponse)
        XCTAssertEqual(service.responses.count, 2)
        XCTAssertEqual(service.responses[bResponse.uid]?.uid, bResponse.uid)

        // Test updating an existing response
        let updatedAResponse = SurveyResponse(
            uid: Uids.a.rawValue,
            type: .multipleChoiceQuestion,
            values: [
                Uids.b.rawValue: Failable(uid: UUID().uuidString, value: "Purple"),
                UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue")
            ]
        )
        service.addResponse(response: updatedAResponse)
        XCTAssertEqual(service.responses.count, 2)
        XCTAssertEqual(service.responses[aResponse.uid]?.values.count, 2)
        XCTAssertEqual(service.responses[aResponse.uid]?.values[Uids.b.rawValue]?.value, "Purple")
    }

    func testContactForm() {
        let key = Uids.i.rawValue
        let response = Uids.i.response
        let valueKey = Uids.s.rawValue
        service.addResponse(response: response)
        XCTAssertEqual(service.responses.count, 1)
        XCTAssertEqual(service.responses[key]!.uid, key)
        XCTAssertEqual(service.responses[key]!.values[valueKey]?.value, "johndoe@example.com")
    }

    func testCommentsForm() {
        let key = Uids.o.rawValue
        let response = Uids.o.response
        let valueKey = Uids.m.rawValue
        service.addResponse(response: response)
        XCTAssertEqual(service.responses.count, 1)
        XCTAssertEqual(service.responses[key]!.uid, key)
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
        case .a: return SurveyResponse(uid: Uids.a.rawValue, type: .multipleChoiceQuestion, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Red"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue")
        ])
        case .b: return SurveyResponse(uid: Uids.b.rawValue, type: .multipleChoiceQuestion, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Black"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Orange")
        ])
        case .c:
            return SurveyResponse(uid: Uids.c.rawValue, type: .inlineQuestionGroup, values: [
                UUID().uuidString: Failable(uid: UUID().uuidString, value: "Example Text Input Response")
            ])
        case .d:
            return SurveyResponse(uid: Uids.d.rawValue, type: .multipleChoiceQuestion, values: [
                UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option A"),
                UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option B"),
                UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option C")
            ])
        case .e:
            return SurveyResponse(uid: Uids.e.rawValue, type: .binaryChoice, values: [
                UUID().uuidString: Failable(uid: UUID().uuidString, value: "Option A")
            ])
        case .h: return SurveyResponse(uid: Uids.h.rawValue, type: .binaryChoice, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "No")
        ])

        case .i: return SurveyResponse(uid: Uids.i.rawValue, type: .contactForm, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "John"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Doe"),
            Uids.s.rawValue: Failable(uid: UUID().uuidString, value: "johndoe@example.com"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "1234567890")
        ])

        case .j: return SurveyResponse(uid: Uids.j.rawValue, type: .inlineQuestionGroup, values: [
            Uids.a.rawValue: Failable(uid: UUID().uuidString, value: "Red"),
            Uids.b.rawValue: Failable(uid: UUID().uuidString, value: "Black")
        ])

        case .k: return SurveyResponse(uid: Uids.k.rawValue, type: .commentsForm, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Great product!")
        ])

        case .l: return SurveyResponse(uid: Uids.l.rawValue, type: .multipleChoiceQuestion, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Red"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Green"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Black"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "White")
        ])

        case .m: return SurveyResponse(uid: Uids.m.rawValue, type: .binaryChoice, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "No")
        ])

        case .n: return SurveyResponse(uid: Uids.n.rawValue, type: .inlineQuestionGroup, values: [
            Uids.a.rawValue: Failable(uid: UUID().uuidString, value: "Red"),
            Uids.b.rawValue: Failable(uid: UUID().uuidString, value: "Black"),
            Uids.c.rawValue: Failable(uid: UUID().uuidString, value: "Green")
        ])

        case .o: return SurveyResponse(uid: Uids.o.rawValue, type: .commentsForm, values: [
            Uids.m.rawValue: Failable(uid: UUID().uuidString, value: "Keep up the good work!")
        ])

        case .p: return SurveyResponse(uid: Uids.p.rawValue, type: .multipleChoiceQuestion, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Android"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "iOS"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Windows"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "MacOS")
        ])

        default: return SurveyResponse(uid: Uids.a.rawValue, type: .multipleChoiceQuestion, values: [
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Red"),
            UUID().uuidString: Failable(uid: UUID().uuidString, value: "Blue")
        ])
        }
    }
}
