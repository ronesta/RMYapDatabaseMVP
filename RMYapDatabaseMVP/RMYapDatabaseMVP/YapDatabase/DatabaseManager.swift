//
//  DatabaseManager.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import Foundation
import YapDatabase

final class DatabaseManager: StorageManagerProtocol {
    private let charactersKey = "charactersKey"
    private let charactersCollection = "characters"
    private let imagesCollection = "images"
    private let charactersIdsCollection = "charactersIdsCollection"
    private let database: YapDatabase
    private let connection: YapDatabaseConnection

    init() {
        do {
            database = try DatabaseManager.setupDatabase()
            database.registerCodableSerialization(Character.self, forCollection: charactersCollection)
            connection = database.newConnection()
        } catch {
            fatalError("Failed to initialize YapDatabase with error: \(error)")
        }
    }

    private static func setupDatabase() throws -> YapDatabase {
        guard let baseDir = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask).first else {
            throw YapDatabaseError.databaseInitializationFailed
        }

        let databasePath = baseDir.appendingPathComponent("database.sqlite")

        guard let database = YapDatabase(url: databasePath) else {
            throw YapDatabaseError.databaseInitializationFailed
        }

        return database
    }

    func saveCharacter(_ character: Character) {
        connection.readWrite { transaction in
            transaction.setObject(character, forKey: "\(character.id)", inCollection: charactersCollection)

            var charactersIds = transaction.object(
                forKey: charactersIdsCollection,
                inCollection: charactersIdsCollection) as? [String] ?? []

            if !charactersIds.contains("\(character.id)") {
                charactersIds.append("\(character.id)")
                transaction.setObject(charactersIds, forKey: charactersIdsCollection, inCollection: charactersIdsCollection)
            }
        }
    }

    func saveCharacters(_ characters: [Character]) {
        do {
            let data = try JSONEncoder().encode(characters)
            connection.readWrite { transaction in
                transaction.setObject(data, forKey: charactersKey, inCollection: charactersCollection)
            }
        } catch {
            print("Failed to encode characters: \(error)")
        }
    }

    func loadCharacter(characterId: String) -> Character? {
        var character: Character?

        connection.read { transaction in
            character = transaction.object(forKey: characterId, inCollection: charactersCollection) as? Character
        }
        return character
    }

    func loadCharacters() -> [Character] {
        var characters = [Character]()

        connection.read { transaction in
            if let charactersIds = transaction.object(forKey: charactersIdsCollection, inCollection: charactersIdsCollection) as? [String] {
                for id in charactersIds {
                    if let character = transaction.object(
                        forKey: id,
                        inCollection: charactersCollection) as? Character {
                        characters.append(character)
                    }
                }
            }
        }

        return characters
    }

    func saveImage(_ image: Data, key: String) {
        connection.readWrite { transaction in
            transaction.setObject(image, forKey: key, inCollection: imagesCollection)
        }
    }

    func loadImage(characterId: String) -> Data? {
        var result: Data?

        connection.read { transaction in
            if let data = transaction.object(forKey: characterId, inCollection: imagesCollection) as? Data {
                result = data
            } else {
                result = nil
            }
        }
        return result
    }
}

// MARK: extension DatabaseManager
extension DatabaseManager {
    func clearCharacter(characterId: String) {
        connection.readWrite { transaction in
            transaction.removeObject(forKey: characterId, inCollection: charactersCollection)
        }
    }

    func clearCharacters() {
        connection.readWrite { transaction in
            transaction.removeAllObjects(inCollection: charactersCollection)
        }
    }

    func clearImage(characterId: String) {
        connection.readWrite { transaction in
            transaction.removeObject(forKey: characterId, inCollection: imagesCollection)
        }
    }
}

