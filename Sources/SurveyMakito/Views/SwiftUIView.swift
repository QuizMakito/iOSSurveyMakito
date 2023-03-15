//
//  SwiftUIView.swift
//
//
//  Created by Kris Steigerwald on 3/13/23.
//

import SwiftUI

struct SurveySplashView: View {
    var body: some View {
        SurveyWrap(color: .pink) {
            Text("hello...")
        } footer: {
            Text("footer..")
        }
    }
}

struct SurveyWrap<C: View, F: View>: View {
    var color: Color?
    var bgImage: Image?
    var content: () -> C
    var footer: () -> F
    var body: some View {
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

    var background: some View {
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
