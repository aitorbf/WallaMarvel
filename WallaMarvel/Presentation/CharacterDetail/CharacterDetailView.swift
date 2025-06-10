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
                    Group {
                        if isLandscape {
                            landscapeView(height: geometry.size.height)
                        } else {
                            portraitView
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getComics()
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
    
    private var characterHeader: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage.url(URL(string: viewModel.character.thumbnail.landscape))
                .placeholder {
                    Color.gray
                        .frame(maxWidth: .infinity)
                }
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
    }
    
    private var characterName: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name")
                .font(.title2.bold())
            
            Text(viewModel.character.name)
                .font(.body)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }
    
    private var characterDescription: some View {
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
    
    private var comics: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Comics")
                .font(.title2.bold())
                .padding(.horizontal)
            
            if viewModel.isLoadingComics {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if viewModel.comics.isEmpty {
                Text("No comics available.")
                    .font(.body)
                    .italic()
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(Array(viewModel.comics.enumerated()), id: \.element.id) { index, comic in
                            KFImage.url(URL(string: comic.thumbnail.portrait))
                                .placeholder {
                                    Color.gray
                                        .frame(width: 80, height: 120)
                                }
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 120)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(comic.id == viewModel.selectedComic?.id ?? 0 ? Color.primary : Color.clear, lineWidth: 3)
                                )
                                .padding(.vertical, 4)
                                .onAppear {
                                    Task {
                                        await viewModel.loadMoreComics(currentIndex: index)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        viewModel.selectComic(comic)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private var comicDetail: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                KFImage.url(URL(string: viewModel.selectedComic?.thumbnail.portrait ?? ""))
                    .placeholder {
                        Color.gray
                            .frame(width: 80, height: 120)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.selectedComic?.title ?? "Unknown Title")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    if let description = viewModel.selectedComic?.description, !description.isEmpty {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(4)
                    } else {
                        Text("No description available.")
                            .font(.subheadline)
                            .italic()
                            .foregroundColor(.gray)
                    }
                    
                    if let pages = viewModel.selectedComic?.pages {
                        Text("Pages: \(pages)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .shadow(color: .primary, radius: 2)
            .padding(.horizontal)
        }
    }
    
    private var portraitView: some View {
        VStack(alignment: .leading, spacing: 12) {
            characterHeader
            characterDescription
            comics
            if viewModel.selectedComic != nil {
                comicDetail
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
    }
    
    private func landscapeView(height: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                KFImage.url(URL(string: viewModel.character.thumbnail.portrait))
                    .placeholder {
                        Color.gray
                            .frame(maxHeight: height * 0.7)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: height * 0.7)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 16) {
                    characterName
                    characterDescription
                }
            }
            .padding()
            
            comics
            
            if viewModel.selectedComic != nil {
                comicDetail
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
    }
}

#Preview {
    CharacterDetailView(viewModel: MockCharacterDetailViewModel())
}

// swiftlint:enable no_magic_numbers
