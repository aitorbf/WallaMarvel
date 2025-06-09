//
//  CharacterDetailView.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 9/6/25.
//
// swiftlint:disable no_magic_numbers

import SwiftUI
import Kingfisher

struct CharacterDetailView<ViewModel: CharacterDetailViewModel>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            toolbar
            
            GeometryReader { geometry in
                let isLandscape = geometry.size.width > geometry.size.height
                
                ScrollView(showsIndicators: false) {
                    if isLandscape {
                        landscapeView(height: geometry.size.height)
                    } else {
                        portraitView
                    }
                }
            }
        }
    }
    
    private var toolbar: some View {
        ZStack {
            Text(viewModel.character.name)
                .foregroundColor(.primary)
                .lineLimit(1)
                .padding(.leading, 32)
                .padding(.trailing, 32)
            
            HStack {
                Button {
                    coordinator.navigateBack()
                }
                label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                        .frame(width: 12, height: 12)
                        .padding()
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var portraitView: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .bottomLeading) {
                KFImage.url(URL(string: viewModel.character.thumbnail.landscape))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 150)
                
                Text(viewModel.character.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.title2.bold())
                
                if !viewModel.character.description.isEmpty {
                    Text(viewModel.character.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                } else {
                    Text("No description available.")
                        .font(.body)
                        .italic()
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func landscapeView(height: CGFloat) -> some View {
        HStack(alignment: .top, spacing: 12) {
            KFImage.url(URL(string: viewModel.character.thumbnail.portrait))
                .resizable()
                .scaledToFit()
                .frame(maxHeight: height * 0.7)
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                        .font(.title2.bold())
                    
                    Text(viewModel.character.name)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.title2.bold())
                    
                    if !viewModel.character.description.isEmpty {
                        Text(viewModel.character.description)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    } else {
                        Text("No description available.")
                            .font(.body)
                            .italic()
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
}

#Preview {
    CharacterDetailView(viewModel: MockCharacterDetailViewModel())
}

// swiftlint:enable no_magic_numbers
