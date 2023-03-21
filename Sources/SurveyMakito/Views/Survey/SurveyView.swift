//
//  SwiftUIView 2.swift
//
//
//  Created by Kris Steigerwald on 3/15/23.
//
import SwiftUI
import Combine

public enum SurveyEvent {
    case next
    case back
    case submit
    case invoke
}

struct PreviewStruct: View {
    @State var index: Int = 0
    @State public var survey: Survey
    @State public var event: SurveyEvent = .invoke
    @State public var showingSheet: Bool = false
    var body: some View {
        VStack {
            Button(action: {
                showingSheet = true
            }, label: {
                Text("Show Survey")
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(minWidth: 200, maxWidth: .infinity, minHeight: 40)
                            .foregroundColor(.blue)
                            .padding(10)
                    )
            })
            //
        }
        .sheet(isPresented: $showingSheet) {
            SurveyView(survey: $survey, index: $index, event: $event, userId: "12345")
        }
        .onChange(of: index, perform: { val in
            print(val)
        })

    }
}

public struct SurveyView: View {

    @Namespace private var namespace
    @State private var isAnimating = false
    @ObservedObject public var surveyService: SurveyService

    // A single response that comes from a question
    @State var response: SurveyResponse = SurveyResponse()

    @Binding public var survey: Survey
    @Binding public var index: Int
    @Binding public var event: SurveyEvent
    public let userId: String
    static let log = Logger("SurveyMakito")
    @State public var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss

    public init(
        surveyService: SurveyService = SurveyService(),
        survey: Binding<Survey>,
        index: Binding<Int>,
        event: Binding<SurveyEvent>,
        userId: String
    ) {
        self.surveyService = surveyService
        self._survey = survey
        self._index = index
        self._event = event
        self.userId = userId
    }

    func switchView(question: SurveyQuestion) -> some View {
        switch question.type {
        case .binaryChoice:
            return AnyView(BinaryQuestionView(question: question, response: $response))
        case .multipleChoiceQuestion:
            return AnyView(MultipleChoiceQuestionView(question: question, response: $response))
        case .inlineQuestionGroup:
            return AnyView(InlineMultipleChoiceQuestionGroupView(question: question))
        case .contactForm:
            return AnyView(ContactFormQuestionView(question: question, response: $response))
        case .commentsForm:
            return AnyView(CommentsFormQuestionView(question: question))
        default:
            return AnyView(EmptyView())
        }
    }

    func stackToAnim(questions: [SurveyQuestion]) -> some View {
        AnyView(
            LazyVStack(spacing: 20) {
                if let questions = survey.questions {
                    if let question = questions[index] {
                        switchView(question: question)
                    }
                }
            }.padding()
        )
    }

    public var body: some View {
        SurveyWrap(color: .white) {
            ScrollView {
                if isAnimating {
                    if let questions = survey.questions {
                        stackToAnim(questions: questions)
                            .matchedGeometryEffect(id: "survey", in: namespace)
                    }
                } else {
                    if let questions = survey.questions {
                        stackToAnim(questions: questions)
                            .matchedGeometryEffect(id: "survey", in: namespace)
                    }
                }
            }
        } footer: {
            VStack {
                HStack {
                    if let questions = survey.questions {
                        SurveyNavigationFooterView(questions: questions, index: $index, isAnimating: $isAnimating, event: $event)

                    }
                }
            }
        }
        .onChange(of: index) { _ in
            guard let question = survey.questions?[index] else { return }
            if let response = surveyService.responses[question.uid] {
                self.response = response

            }
        }
        .onChange(of: response) { _ in
            do {
                try surveyService.addResponse(response: response)
                surveyService.log()
            } catch {
                showAlert = true
            }
        }
        .onChange(of: event) { value in
            switch value {
            case .submit:
                Task {
                    do {
                        try await surveyService.submitSurvey(for: userId)
                        dismiss()
                    } catch {
                        print(error)
                        dismiss()
                    }
                }
            default: print(value)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Fatal Error"),
                message: Text("Important data missing" +
                                "determined at this time.")
            )
        }
        .navigationBarTitle("Survey", displayMode: .inline)
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewStruct.preview
            .environmentObject(SurveyService())
    }
}
