//
//  CharacterPresenter.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.01.2025.
//

import Foundation
import UIKit

final class CharacterPresenter: CharacterPresenterProtocol {
    private weak var view: CharacterViewProtocol?
    private let networkManager: NetworkManagerProtocol
    private let storageManager: StorageManagerProtocol

    private var characters = [Character]()

    init(view: CharacterViewProtocol,
         networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.view = view
        self.networkManager = networkManager
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
        } else {
            networkManager.getCharacters { [weak self] result in
                switch result {
                case .success(let characters):
                    DispatchQueue.main.async {
                        self?.characters = characters
                        self?.view?.updateCharacters(characters)
                        characters.forEach { character in
                            self?.storageManager.saveCharacter(character, key: "\(character.id)")
                        }
                    }
                case .failure(let error):
                    print("Failed to fetch characters: \(error.localizedDescription)")
                }
            }
        }
    }

    func loadImage(for character: Character, completion: @escaping (UIImage?) -> Void) {
        networkManager.loadImage(from: character.image, completion: completion)
    }
}
