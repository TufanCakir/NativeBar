//
//  OnboardingView.swift
//  NativeBar
//
//  Created by Tufan Cakir on 14.11.26.
//

import SwiftUI

struct OnboardingView: View {
    let onComplete: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .gray],
                startPoint: .trailing,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("Willkommen bei NativeBar")
                    .font(.title)
                Text("Wir richten alles für Sie ein")

                Button("Get Started") {
                    onComplete()
                }
                .buttonStyle(.bordered)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    OnboardingView(onComplete: {})
}
