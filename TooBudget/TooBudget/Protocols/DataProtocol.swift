//
//  DataProtocol.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/12/24.
//

import SwiftData

protocol DataProtocol {
    func setupContainer(inMemory: Bool) -> ModelContainer
    func deleteModel() throws
}
