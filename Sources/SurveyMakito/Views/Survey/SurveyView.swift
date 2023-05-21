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
    case none
}

public struct SurveyColors {
    public let inactive: Color
    public let active: Color

    public init(
        inactive: Color = Color(red: 0.9391835927963257, green: 0.9326529502868652, blue: 0.9873470067977905, opacity: 1),
        active: Color = Color(red: 239/255, green: 93/255, blue: 168/255)
    ) {
        self.inactive = inactive
        self.active = active
    }
}

struct PreviewStruct: View {
    @State var index: Int = 0
    @State public var survey: Survey
    @State public var event: SurveyEvent = .invoke

    // TODO: Change to false at the end
    @State public var showingSheet: Bool = true

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
    @State public var canGoNext = false

    @Namespace private var namespace
    @State private var isAnimating = false
    @StateObject public var surveyService: SurveyService

    // A single response that comes from a question
    @State var response: SurveyResponse = SurveyResponse()

    @State public var allowNext: Bool = false

    @Binding public var survey: Survey
    @Binding public var index: Int
    @Binding public var event: SurveyEvent
    public let userId: String
    static let log = Logger("SurveyMakito")
    @State public var showAlert: Bool = false
    public let colors: SurveyColors
    @Environment(\.dismiss) var dismiss

    public init(
        survey: Binding<Survey>,
        index: Binding<Int>,
        event: Binding<SurveyEvent>,
        userId: String,
        colors: SurveyColors = SurveyColors()
    ) {
        self._surveyService = StateObject(wrappedValue: SurveyService())
        self._survey = survey
        self._index = index
        self._event = event
        self.userId = userId
        self.colors = colors
    }

    func switchView(question: SurveyQuestion) -> some View {
        switch question.type {
        case .binaryChoice:
            return AnyView(BinaryQuestionView(question: question, response: $response))
        case .multipleChoiceQuestion:
            return AnyView(MultipleChoiceQuestionView(question: question, response: $response, colors: colors))
        case .inlineQuestionGroup:
            return AnyView(InlineMultipleChoiceQuestionGroupView(question: question))
        case .contactForm:
            return AnyView(ContactFormQuestionView(question: question, response: $response, colors: colors, canGoNext: $canGoNext))
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
                    switchView(question: questions[index])
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
                        SurveyNavigationFooterView(questions: questions, index: $index, isAnimating: $isAnimating, event: $event, canGoNext: $canGoNext)
                    }
                }.padding(.bottom)
                .padding(15)
            }.frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
        }
        .transition(.move(edge: .leading))
        .onChange(of: index) { _ in
            guard let question = survey.questions?[index] else { return }
            if let response = surveyService.responses[question.uid] {
                self.response = response
            }
        }

        .onChange(of: response) { _ in
            if response != SurveyResponse() {
                do {
                    try surveyService.addResponse(response: response)
                } catch {
                    showAlert = true
                }
            }
            canGoNext = !response.values.values.isEmpty
            event = .none
        }
        .onChange(of: event) { value in
            switch value {
            case .next:
                guard let question = survey.questions?[index] else { return }
                if question.isRequired && canGoNext {
                    goNext()
                }
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
        .edgesIgnoringSafeArea(.bottom)
    }

    func goNext() {
        guard let questions = survey.questions else { return }
        withAnimation {
            index = (index + 1) % questions.count
            isAnimating = true
            canGoNext = false
            response = SurveyResponse()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation {
                isAnimating = false
            }
        }
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewStruct.preview
    }
}
