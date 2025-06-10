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
                if viewModel.isLoading {
                    ProgressView()
                } else {
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
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
            .navigationTitle("List of Characters")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
            
            Text(character.name)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

#Preview {
    CharactersListView(viewModel: MockCharactersListViewModel())
}

// swiftlint:enable no_magic_numbers
