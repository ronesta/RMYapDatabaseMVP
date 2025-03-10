//
//  CharacterAssembly.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 27.02.2025.
//

import Foundation
import UIKit.UIViewController

final class CharacterAssembly {
    func build() -> UIViewController {
        let storageManager = DatabaseManager()
        let сharacterService = CharacterService()
        let imageLoader = ImageLoader(storageManager: storageManager)

        let presenter = CharacterPresenter(
            сharacterService: сharacterService,
            storageManager: storageManager
        )

        let tableViewDataSource = CharacterTableViewDataSource(imageLoader: imageLoader)

        let viewController = CharacterViewController(
            presenter: presenter,
            tableViewDataSource: tableViewDataSource
        )

        presenter.view = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
