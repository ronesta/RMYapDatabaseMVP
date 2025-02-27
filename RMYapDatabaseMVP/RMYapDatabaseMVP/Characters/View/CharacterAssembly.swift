//
//  CharacterAssembly.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 27.02.2025.
//

import Foundation
import UIKit

final class CharacterAssembly {
    func build() -> UIViewController {
        let viewController = CharacterViewController()
        let storageManager = DatabaseManager()
        let networkManager = NetworkManager(storageManager: storageManager)

        let presenter = CharacterPresenter(
            view: viewController,
            networkManager: networkManager,
            storageManager: storageManager
        )

        let tableViewDataSource = CharacterTableViewDataSource(presenter: presenter)

        viewController.presenter = presenter
        viewController.tableViewDataSource = tableViewDataSource

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
