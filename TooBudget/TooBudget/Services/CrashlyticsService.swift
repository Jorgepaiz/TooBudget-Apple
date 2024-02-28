//
//  CrashlyticsService.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/23/24.
//

import Foundation
import FirebaseCrashlytics
import FirebaseAuth

final class CrashlyticsService {
    static func logError(_ error: Error) {
        Crashlytics.crashlytics().record(error: error)
    }
    
    static func setUserId(_ userId: String) {
        Crashlytics.crashlytics().setUserID(userId)
    }
}
