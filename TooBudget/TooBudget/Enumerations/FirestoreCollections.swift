//
//  FirestoreCollections.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/20/24.
//

import Foundation

enum FirestoreCollections {
    case users
    
    var name: String {
        switch self {
        case .users:
            return "Users"
        }
    }
}
