//
//  CoordinatorProtocol.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

protocol CoordinatorProtocol {
    var appCoordinator: AppCoordinator { get }
    init(_ appCoordinator: AppCoordinator)
    func show() -> any View
}
