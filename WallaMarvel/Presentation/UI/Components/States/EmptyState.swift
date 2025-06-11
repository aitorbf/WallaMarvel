//
//  EmptyState.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//
// swiftlint:disable no_magic_numbers

import SwiftUI

struct EmptyState: View {
    let title: String
    let message: String
    let iconName: String?

    var body: some View {
        VStack(spacing: .zero) {
            if let iconName = iconName {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 32)
                    .accessibilityHidden(true)
            }

            Text(title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    EmptyState(
        title: "No Results",
        message: "We couldn't find any result.",
        iconName: "magnifyingglass"
    )
}

// swiftlint:enable no_magic_numbers
