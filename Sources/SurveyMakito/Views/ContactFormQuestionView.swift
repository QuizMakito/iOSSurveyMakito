//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct Contact {
    public var selectedChoices: [String: String]?
    public var emailAddress: String?
    public var name: String?
    public var company: String?
    public var phoneNumber: String?
    public var feedback: String?

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

    public var body: some View {
        VStack(alignment: .center) {
            Text(question.title)
                .font(.title2)
            VStack(alignment: .leading, spacing: 20) {

                /*
                 if let choices = question.choices {


                 Text(question.title)
                 .font(.headline)

                 MultipleChoiceResponseListView(
                 choices: question.choices,
                 selectedChoices: $selectedChoices

                 }
                 )*/

                Text("Email Address")
                    .font(.headline)
                TextField("Email Address", text: $emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

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
            .onChange(of: selectedChoices) { _ in

                /*
                 surveyService.updateContactFormQuestionResponse(
                 uid: question.uid,
                 choices: selected
                 )*/
            }
            .onChange(of: emailAddress) { value in
                contact = contact.changing(path: \.emailAddress, to: value)
                /*
                 surveyService.updateContactFormQuestionResponse(
                 uid: question.uid,
                 emailAddress: newValue
                 )*/
            }
            .onChange(of: name) { value in
                contact = contact.changing(path: \.name, to: value)
                /*
                 surveyService.updateContactFormQuestionResponse(
                 uid: question.uid,
                 name: newValue
                 )*/
            }
            .onChange(of: company) { value in
                contact = contact.changing(path: \.company, to: value)
                /*
                 surveyService.updateContactFormQuestionResponse(
                 uid: question.uid,
                 company: newValue
                 )*/
            }
            .onChange(of: phoneNumber) { value in
                contact = contact.changing(path: \.phoneNumber, to: value)
                /*
                 surveyService.updateContactFormQuestionResponse(
                 uid: question.uid,
                 phoneNumber: newValue
                 )*/
            }
            .onChange(of: feedback) { value in
                contact = contact.changing(path: \.feedback, to: value)
                /*
                 surveyService.updateContactFormQuestionResponse(
                 uid: question.uid,
                 feedback: newValue
                 )
                 */
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
        return ContactFormQuestionView(question: question, response: .constant(SurveyResponse()))
    }
}

struct ContactFormQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormQuestionView.example
            .environmentObject(SurveyService())
    }
}
