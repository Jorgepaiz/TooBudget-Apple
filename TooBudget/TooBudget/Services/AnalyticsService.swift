//
//  AnalyticsService.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/23/24.
//

import Foundation
import FirebaseAnalytics
import FirebaseAuth

final class AnalyticsService {
    static func currentScreenView(_ screen: AppViews) {
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [AnalyticsParameterScreenName: screen.name]
        )
    }
    
    static func specialScreenView(_ screen: String) {
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [AnalyticsParameterScreenName: screen]
        )
    }
    
    static func logInUser() {
        if let user = Auth.auth().currentUser,
           let email = user.email,
           let fullname = user.displayName {
            CrashlyticsService.setUserId(user.uid)
            Analytics.setUserID(user.uid)
            Analytics.setUserProperty("email", forName: email)
            Analytics.setUserProperty("fullName", forName: fullname)
            Analytics.logEvent(
                AnalyticsEventLogin,
                parameters: [:]
            )
        }
    }
    
    static func logOut() {
        Analytics.logEvent(
            AnalyticsEventSignUp,
            parameters: [AnalyticsParameterEndDate: Date()]
        )
    }
    
}
