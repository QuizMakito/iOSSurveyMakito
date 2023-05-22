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
    @Binding public var response: SurveyResponse
    public let colors: SurveyColors

    @State private var isEmailValid: Bool = true
    @Binding public var canGoNext: Bool

    @State var emailIsFilled = false
    @State var nameIsFilled = false

    public var body: some View {
        VStack(alignment: .center) {
            Text(question.title)
                .font(.title2)
            VStack(alignment: .leading, spacing: 20) {

                Text("Email Address")
                    .font(.headline)
                TextField("Email Address", text: $emailAddress, onEditingChanged: { isChanged in
                    if !isChanged {
                        if isValidEmail(str: emailAddress) {
                            self.isEmailValid = true
                        } else {
                            self.isEmailValid = false
                            self.emailAddress = ""
                        }
                    }
                })
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isEmailValid ? .clear : .red, lineWidth: 2)
                )
                Text("Name")
                    .font(.headline)
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.namePhonePad)
                    .textContentType(.name)
                Text("Feedback")
                    .font(.headline)
                TextField("Feedback", text: $feedback, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
            }
            .padding()
            .onChange(of: emailAddress, perform: { value in
                emailIsFilled = !value.isEmpty && isEmailValid
            })
            .onChange(of: name) { value in
                nameIsFilled = !value.isEmpty
            }
            .onChange(of: company) { _ in }
            .onChange(of: phoneNumber) { _ in }
            .onChange(of: feedback) { _ in }
            .onChange(of: contact) { _ in
                response = contact.toSurveyResponse(questionId: question.uid)
            }
            .onChange(of: canGoNext, perform: { _ in
                contact = contact.changing(path: \.emailAddress, to: emailAddress)
                contact = contact.changing(path: \.name, to: name)
                contact = contact.changing(path: \.company, to: company)
                contact = contact.changing(path: \.phoneNumber, to: phoneNumber)
                contact = contact.changing(path: \.feedback, to: feedback)
            })
            .onChange(of: nameIsFilled, perform: { newValue in
                canGoNext = newValue && emailIsFilled
            })
            .onChange(of: emailIsFilled, perform: { newValue in
                canGoNext = newValue && nameIsFilled
            })
            .onAppear {
                canGoNext = false
            }
        }
    }
    func isValidEmail(str: String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let email = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = email.evaluate(with: str)
        return result
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
        return ContactFormQuestionView(question: question, response: .constant(SurveyResponse()), colors: SurveyColors(), canGoNext: .constant(false))
    }
}

struct ContactFormQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormQuestionView.example
            .environmentObject(SurveyService())
    }
}
