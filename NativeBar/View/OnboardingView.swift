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
                colors: [.black, .gray, .black],
                startPoint: .trailing,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 12) {
                Spacer()

                headerView

                Spacer()

                featuresView

                Spacer()

                startButton
            }
            .padding()
        }
        .foregroundStyle(.white)
    }

    private var headerView: some View {

        VStack {
            Text("Willkommen bei NativeBar")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(.black)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [.black, .white, .black],
                        startPoint: .trailing,
                        endPoint: .leading
                    ),
                    lineWidth: 3
                )
        }
    }

    private var featuresView: some View {
        VStack(spacing: 12) {
            featureRow(
                symbol: "book.closed.fill",
                title: "Swift lernen",
                description: "Entdecke Grundlagen und wichtige Konzepte."
            )

            featureRow(
                symbol: "doc.text.fill",
                title: "Dokumentation",
                description: "Lies Erklärungen."
            )

            featureRow(
                symbol: "magnifyingglass",
                title: "Schnell suchen",
                description: "Finde Themen und Dokumentationen."
            )
        }
        .padding()
        .background(.black)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [.black, .white, .black],
                        startPoint: .trailing,
                        endPoint: .leading
                    ),
                    lineWidth: 3
                )
        }
    }

    private func featureRow(
        symbol: String,
        title: String,
        description: String
    ) -> some View {
        VStack {
            Text(title)
                .font(.headline)

            Text(description)
                .font(.subheadline)
        }
    }

    private var startButton: some View {
        VStack {
            Button {
                onComplete()
            } label: {
                Text("Jetzt starten")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .padding()
            .background(.black)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        LinearGradient(
                            colors: [.black, .white, .black],
                            startPoint: .trailing,
                            endPoint: .leading
                        ),
                        lineWidth: 3
                    )
            }
        }
    }
}

#Preview {
    OnboardingView(onComplete: {})
}
