//
//  CharacterDataSourceProtocol.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.01.2025.
//

import Foundation
import UIKit

protocol CharacterDataSourceProtocol: UITableViewDataSource {
    var characters: [Character] { get set }
}
