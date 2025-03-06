//
//  CharacterPresenter.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.01.2025.
//

import Foundation

final class CharacterPresenter: CharacterPresenterProtocol {
    weak var view: CharacterViewProtocol?

    private let сharacterService: CharacterServiceProtocol
    private let storageManager: StorageManagerProtocol

    private var characters = [Character]()

    init(сharacterService: CharacterServiceProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.сharacterService = сharacterService
        self.storageManager = storageManager
    }

    func viewDidLoad() {
        getCharacters()
    }

    private func getCharacters() {
        let savedCharacters = storageManager.loadCharacters()

        if !savedCharacters.isEmpty {
            characters = savedCharacters
            view?.updateCharacters(characters)
            return
        }

        сharacterService.getCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.view?.updateCharacters(characters)
                characters.forEach { character in
                    self?.storageManager.saveCharacter(character)
                }
            case .failure(let error):
                print("Failed to fetch characters: \(error.localizedDescription)")
            }
        }
    }
}
