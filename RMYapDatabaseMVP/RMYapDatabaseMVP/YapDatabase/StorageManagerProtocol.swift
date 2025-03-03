//
//  StorageManagerProtocol.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.01.2025.
//

import Foundation

protocol StorageManagerProtocol {
    func saveCharacter(_ character: Character)

    func saveCharacters(_ characters: [Character])

    func loadCharacter(characterId: String) -> Character?

    func loadCharacters() -> [Character]

    func clearCharacters()

    func saveImage(_ image: Data, key: String)

    func loadImage(characterId: String) -> Data?

    func clearImage(characterId: String)
}
