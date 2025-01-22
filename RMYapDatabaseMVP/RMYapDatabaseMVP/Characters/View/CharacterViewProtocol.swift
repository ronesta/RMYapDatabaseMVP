//
//  CharacterViewProtocol.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.01.2025.
//

import Foundation

protocol CharacterViewProtocol: AnyObject {
    func updateCharacters(_ characters: [Character])
    func showError(_ message: String)
}
