import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    
    func screenTitle() -> String
    func getHeroes()
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [Character])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getCharactersUseCase: GetCharactersUseCase
    
    init(getCharactersUseCase: GetCharactersUseCase = GetCharactersUseCaseImpl()) {
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        Task {
            do {
                let charactersPage = try await getCharactersUseCase.execute()
                print("Characters \(charactersPage.characters)")
                ui?.update(heroes: charactersPage.characters)
            } catch {
                print("Error fetching heroes: \(error.localizedDescription)")
            }
        }
    }
}
