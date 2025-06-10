//
//  ErrorState.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//
// swiftlint:disable no_magic_numbers

import SwiftUI

struct ErrorState: View {
    
    let title: String
    let message: String
    let iconName: String?
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: .zero) {
            if let icon = iconName {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 32)
            }

            Text(title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 16)

            Button(action: retryAction) {
                Label("Retry", systemImage: "arrow.clockwise")
                    .foregroundColor(.primary)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.primary, lineWidth: 1)
                    }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorState(
        title: "Oops!",
        message: "Something went wrong. Please try again.",
        iconName: "exclamationmark.triangle",
        retryAction: {}
    )
}

// swiftlint:enable no_magic_numbers
