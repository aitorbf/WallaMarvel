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
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(viewModel.characters, id: \.id) { character in
                                HStack(spacing: 12) {
                                    KFImage.url(URL(string: character.thumbnail))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .padding(.leading, 12)
                                        .padding(.top, 12)
                                    
                                    Text(character.name)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("List of Characters")
        }
        .onAppear {
            Task {
                await viewModel.getCharacters()
            }
        }
    }
}

#Preview {
    CharactersListView(viewModel: MockCharactersListViewModel())
}

// swiftlint:enable no_magic_numbers
