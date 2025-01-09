//
//  YapDatabaseError.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import Foundation

enum YapDatabaseError: Error {
    case databaseInitializationFailed
    case encodingFailed(Error)
    case decodingFailed(Error)
}
