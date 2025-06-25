//
//  AppDelegate.swift
//  EApp
//
//  Created by Denis Yaremenko on 24.06.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
///       for EssentialAppUIAcceptanceTests
//        #if DEBUG
//        configuration.delegateClass = DebuggingSceneDelegate.self
//        #endif
        
        return configuration
    }

}

