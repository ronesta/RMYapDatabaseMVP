//
//  CharacterTableViewDataSource.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.01.2025.
//

import Foundation
import UIKit

final class CharacterTableViewDataSource: NSObject, UITableViewDataSource, CharacterDataSourceProtocol {
    var characters = [Character]()
    private let presenter: CharacterPresenterProtocol

    init(presenter: CharacterPresenterProtocol) {
        self.presenter = presenter
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterTableViewCell.id,
            for: indexPath
        ) as? CharacterTableViewCell else {
            return UITableViewCell()
        }

        let character = characters[indexPath.row]

        presenter.loadImage(for: character) { image in
            DispatchQueue.main.async {
                guard let currentCell = tableView.cellForRow(at: indexPath) as? CharacterTableViewCell else {
                    return
                }

                currentCell.configure(with: character, image: image)
            }
        }

        return cell
    }
}
