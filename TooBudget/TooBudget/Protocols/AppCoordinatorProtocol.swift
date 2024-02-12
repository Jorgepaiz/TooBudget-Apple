//
//  AppCoordinatorProtocol.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/10/24.
//

import SwiftUI

protocol AppCoordinatorProtocol: AnyObject {
    var currentView: AnyView { get }
    func navigate(to view: AppViews)
}
