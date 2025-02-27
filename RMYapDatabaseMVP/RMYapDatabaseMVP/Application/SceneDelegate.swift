//
//  SceneDelegate.swift
//  RMYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 09.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window  = UIWindow(windowScene: windowScene)

        let assembly = CharacterAssembly()
        let characterViewController = assembly.build()

        window.rootViewController = characterViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

