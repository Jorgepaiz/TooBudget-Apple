//
//  ViewFactoryProtocol.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/10/24.
//

import SwiftUI

protocol ViewFactoryProtocol {
    func view(for screen: AppViews) -> AnyView
}
