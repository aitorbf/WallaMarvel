//
//  Coordinator.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 9/6/25.
//

import SwiftUI

enum Screen {
    case charactersList
    case characterDetail(Character)
}

/*
The navigation logic is centralized in this Coordinator class,
which is shared across SwiftUI views using the @EnvironmentObject pattern.
This project uses UINavigationController from UIKit to handle navigation
instead of SwiftUI's NavigationStack and NavigationDestination, in order to
support iOS 15 as the minimum deployment target. Starting with iOS 16,
a fully SwiftUI-based navigation stack could be implemented.
*/
final class Coordinator: ObservableObject {
    
    private(set) var navigationController: UINavigationController
    
    init(rootScreen: Screen) {
        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        setup(rootScreen)
    }
    
    func navigateTo(_ screen: Screen) {
        let viewController = UIHostingController(rootView: build(screen).environmentObject(self))
        push(viewController)
    }
    
    func navigateBack() {
        pop()
    }
}

private extension Coordinator {
    
    func setup(_ screen: Screen) {
        let view = build(screen).environmentObject(self)
        let hostingController = UIHostingController(rootView: view)
        navigationController.setViewControllers([hostingController], animated: false)
    }
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .charactersList:
            CharactersListView(
                viewModel: DIContainer.shared.charactersListViewModel()
            )
        case .characterDetail(let character):
            CharacterDetailView(
                viewModel: DIContainer.shared.characterDetailViewModel(character: character)
            )
        }
    }
    
    func push(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
