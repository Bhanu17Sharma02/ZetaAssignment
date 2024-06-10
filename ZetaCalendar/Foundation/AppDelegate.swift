//
//  AppDelegate.swift
//  ZetaCalendar
//
//  Created by Bhanu Sharma on 10/06/24.
//

import Foundation
import UIKit
import GoogleSignIn

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            // Check if `user` is nil, otherwise, user has been restored.
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
