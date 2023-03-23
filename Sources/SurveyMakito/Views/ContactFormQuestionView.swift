//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct Contact: Codable, Hashable {
    public var selectedChoices: [String: String]?
    public var emailAddress: String?
    public var name: String?
    public var company: String?
    public var phoneNumber: String?
    public var feedback: String?
    public var responseUID: String = UUID().uuidString

    init(
        selectedChoices: [String: String]? = nil,
        emailAddress: String? = nil,
        name: String? = nil,
        company: String? = nil,
        phoneNumber: String? = nil,
        feedback: String? = nil
    ) {
        self.selectedChoices = selectedChoices
        self.emailAddress = emailAddress
        self.name = name
        self.company = company
        self.phoneNumber = phoneNumber
        self.feedback = feedback
    }

    func changing<T>(path: WritableKeyPath<Contact, T>, to value: T) -> Contact {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }

    func toSurveyResponse(questionId: String) -> SurveyResponse {
        var values: [String: Failable] = [:]
        if let name = name {
            values["name"] = Failable(value: name)
        }
        if let company = company {
            values["company"] = Failable(value: company)
        }
        if let emailAddress = emailAddress {
            values["emailAddress"] = Failable(value: emailAddress)
        }
        if let phoneNumber = phoneNumber {
            values["phoneNumber"] = Failable(value: phoneNumber)
        }
        if let feedback = feedback {
            values["feedback"] = Failable(value: feedback)
        }

        let surveyResponse = SurveyResponse(uid: responseUID, questionId: questionId, type: .contactForm, values: values)
        return surveyResponse
    }

}

public struct ContactFormQuestionView: View {
    @EnvironmentObject public var surveyService: SurveyService

    public let question: SurveyQuestion

    @State private var selectedChoices: [String: String] = [:]
    @State private var emailAddress: String = ""
    @State private var name: String = ""
    @State private var company: String = ""
    @State private var phoneNumber: String = ""
    @State private var feedback: String = ""

    @State private var contact: Contact = Contact()
    @Binding var response: SurveyResponse
    public let colors: SurveyColors

    private let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"

    private var isEmailValid: Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: emailAddress)
    }

    public var body: some View {
        VStack(alignment: .center) {
            Text(question.title)
                .font(.title2)
            VStack(alignment: .leading, spacing: 20) {

                Text("Email Address")
                    .font(.headline)
                TextField("Email Address", text: $emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(isEmailValid ? .primary : .red)

                Text("Name")
                    .font(.headline)
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Feedback")
                    .font(.headline)
                TextEditor(text: $feedback)
                    .frame(minHeight: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            .padding()
            .onChange(of: emailAddress) { value in
                contact = contact.changing(path: \.emailAddress, to: value)
            }
            .onChange(of: name) { value in
                contact = contact.changing(path: \.name, to: value)
            }
            .onChange(of: company) { value in
                contact = contact.changing(path: \.company, to: value)
            }
            .onChange(of: phoneNumber) { value in
                contact = contact.changing(path: \.phoneNumber, to: value)
            }
            .onChange(of: feedback) { value in
                contact = contact.changing(path: \.feedback, to: value)
            }
            .onChange(of: contact) { _ in
                response = contact.toSurveyResponse(questionId: question.uid)
            }
        }
    }
}

public extension ContactFormQuestionView {
    static var contactQuestion = ContactFormQuestion(
        uid: "contact_form_question",
        required: true,
        choices: [
            MultipleChoiceResponse(uid: "help", text: "I need help with the app"),
            MultipleChoiceResponse(uid: "general", text: "I have a general question"),
            MultipleChoiceResponse(uid: "feedback", text: "I have feedback"),
            MultipleChoiceResponse(uid: "other", text: "Other")
        ],
        emailAddress: "example@example.com",
        name: "John Doe",
        company: "Example Co.",
        phoneNumber: "+1 (555) 555-5555",
        feedback: "This is some feedback."
    )
    static var example: ContactFormQuestionView {
        let question = SurveyQuestion(
            contactFormQuestion: contactQuestion
        )
        return ContactFormQuestionView(question: question, response: .constant(SurveyResponse()), colors: SurveyColors())
    }
}

struct ContactFormQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormQuestionView.example
            .environmentObject(SurveyService())
    }
}
