//
//  ImageLoaderProtocol.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 03.03.2025.
//

import Foundation
import UIKit.UIImage

protocol ImageLoaderProtocol {
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}
