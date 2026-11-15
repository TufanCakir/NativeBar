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

            VStack(spacing: 32) {
                Spacer()

                headerView

                featuresView

                Spacer()

                startButton
            }
            .padding(24)
            .frame(maxWidth: 520)
        }
        .foregroundStyle(.white)
    }

    private var headerView: some View {
        VStack(spacing: 20) {
            Image(systemName: "curlybraces.square.fill")
                .font(.system(size: 72))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.cyan, .white.opacity(0.15))
                .accessibilityHidden(true)

            VStack(spacing: 10) {
                Text("Willkommen bei NativeBar")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
            }
        }
    }

    private var featuresView: some View {
        VStack(alignment: .leading, spacing: 24) {
            featureRow(
                symbol: "book.closed.fill",
                title: "Swift lernen",
                description: "Entdecke Grundlagen und wichtige Konzepte."
            )

            featureRow(
                symbol: "doc.text.fill",
                title: "Dokumentation",
                description: "Lies Erklärungen zu Swift und SwiftUI."
            )

            featureRow(
                symbol: "magnifyingglass",
                title: "Schnell suchen",
                description: "Finde Themen und Dokumentationen."
            )
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.08))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.white.opacity(0.1))
        }
    }

    private func featureRow(
        symbol: String,
        title: String,
        description: String
    ) -> some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: symbol)
                .font(.title2)
                .foregroundStyle(.cyan)
                .frame(width: 36)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var startButton: some View {
        VStack(spacing: 12) {
            Button {
                onComplete()
            } label: {
                HStack(spacing: 10) {
                    Text("Jetzt starten")

                    Image(systemName: "arrow.right")
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
            .foregroundStyle(.black)
            .controlSize(.large)

            Text("Lerne in deinem eigenen Tempo.")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
        }
    }
}

#Preview {
    OnboardingView(onComplete: {})
}
