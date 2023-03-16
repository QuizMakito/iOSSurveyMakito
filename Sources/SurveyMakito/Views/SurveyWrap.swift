//
//  SwiftUIView.swift
//
//
//  Created by Kris Steigerwald on 3/13/23.
//

import SwiftUI

public struct SurveySplashView: View {
    public var body: some View {
        SurveyWrap(color: .pink) {
            Text("hello...")
        } footer: {
            Text("footer..")
        }
    }
}

public struct SurveyWrap<C: View, F: View>: View {
    public var color: Color?
    public var bgImage: Image?
    public var content: () -> C
    public var footer: () -> F
    public var body: some View {
        ZStack {
            background
            VStack {
                Spacer()
                content()
                Spacer()
                HStack {
                    footer()
                }
            }
        }
        .environmentObject(SurveyService())
    }

    public var background: some View {
        if let color = color {
            return color.ignoresSafeArea()
        }
        return Color.white.ignoresSafeArea()
    }
}

struct SurveySplashView_Previews: PreviewProvider {
    static var previews: some View {
        SurveySplashView()
    }
}
