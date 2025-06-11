//
//  CharactersListView.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//
// swiftlint:disable no_magic_numbers

import SwiftUI
import Kingfisher

struct CharactersListView<ViewModel: CharactersListViewModel>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded:
                    charactersListView
                case .empty:
                    EmptyState(
                        title: "No Results",
                        message: "We couldn't find any character matching \"\(viewModel.searchText)\". Try a different keyword",
                        iconName: "magnifyingglass"
                    )
                case .error:
                    ErrorState(
                        title: "Oops!",
                        message: "Something went wrong. Please try again.",
                        iconName: "exclamationmark.triangle",
                        retryAction: {
                            Task {
                                await viewModel.getCharacters()
                            }
                        }
                    )
                }
            }
            .navigationTitle("List of Characters")
            .accessibilityLabel("List of Characters")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Search Characters...")
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var charactersListView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(Array(viewModel.characters.enumerated()), id: \.element.id) { index, character in
                    characterListItem(character: character)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreCharacters(currentIndex: index)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.navigateTo(.characterDetail(character))
                        }
                        .accessibilityAddTraits(.isButton)
                }
            }
            .padding(.bottom)
        }
    }
    
    private func characterListItem(character: Character) -> some View {
        HStack(spacing: 12) {
            KFImage.url(URL(string: character.thumbnail.standard))
                .placeholder {
                    Color.gray
                        .frame(width: 80, height: 80)
                }
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .padding(.leading, 12)
                .padding(.top, 12)
                .accessibilityHidden(true)
            
            Text(character.name)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .accessibilityHidden(true)
            
            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(character.name)
        .accessibilityHint("Double tap to view details")
    }
}

#Preview {
    CharactersListView(viewModel: MockCharactersListViewModel())
}

// swiftlint:enable no_magic_numbers
