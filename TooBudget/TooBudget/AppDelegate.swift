//
//  AppDelegate.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import Firebase
import Foundation
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
