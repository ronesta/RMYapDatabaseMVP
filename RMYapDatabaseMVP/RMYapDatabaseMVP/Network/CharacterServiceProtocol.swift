//
//  NetworkManagerProtocol.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.01.2025.
//

import Foundation

protocol CharacterServiceProtocol {
    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}
