//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//

import SwiftUI

public struct ContactFormQuestionView: View {
    @EnvironmentObject public var surveyService: SurveyService

    public let question: SurveyQuestion

    @State private var selectedChoices: [String: String] = [:]
    @State private var emailAddress: String = ""
    @State private var name: String = ""
    @State private var company: String = ""
    @State private var phoneNumber: String = ""
    @State private var feedback: String = ""

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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

            Text("Company")
                .font(.headline)
            TextField("Company", text: $company)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Text("Phone Number")
                .font(.headline)
            TextField("Phone Number", text: $phoneNumber)
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
        .onChange(of: emailAddress) { _ in
            /*
             surveyService.updateContactFormQuestionResponse(
             uid: question.uid,
             emailAddress: newValue
             )*/
        }
        .onChange(of: name) { _ in
            /*
             surveyService.updateContactFormQuestionResponse(
             uid: question.uid,
             name: newValue
             )*/
        }
        .onChange(of: company) { _ in
            /*
             surveyService.updateContactFormQuestionResponse(
             uid: question.uid,
             company: newValue
             )*/
        }
        .onChange(of: phoneNumber) { _ in
            /*
             surveyService.updateContactFormQuestionResponse(
             uid: question.uid,
             phoneNumber: newValue
             )*/
        }
        .onChange(of: feedback) { _ in
            /*
             surveyService.updateContactFormQuestionResponse(
             uid: question.uid,
             feedback: newValue
             )
             */
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
        return ContactFormQuestionView(question: question)
    }
}

struct ContactFormQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormQuestionView.example
            .environmentObject(SurveyService())
    }
}
