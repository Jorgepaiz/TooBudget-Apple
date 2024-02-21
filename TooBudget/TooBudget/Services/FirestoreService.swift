//
//  FirestoreService.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/20/24.
//

import Firebase
import Combine
import FirebaseFirestoreInternal

final class FirestoreService {
    static let shared = FirestoreService()
    private init() {}
    
    private let db = Firestore.firestore()
    
    func fetchAllDocuments<T: Decodable>(from collection: FirestoreCollections, decodingType: T.Type) -> AnyPublisher<[T], FirebaseServiceError> {
        Deferred {
            Future { promise in
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func fetchDocument<T: Decodable>(from collection: FirestoreCollections, decodingType: T.Type) -> AnyPublisher<T?, FirebaseServiceError> {
        Deferred {
            Future { promise in
                
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func addDocument<T: Decodable>(from collection: FirestoreCollections, decodingType: T.Type) -> AnyPublisher<Bool, FirebaseServiceError> {
        Deferred {
            Future { promise in
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func addDocuments<T: Decodable>(from collection: FirestoreCollections, decodingType: T.Type) -> AnyPublisher<Bool, FirebaseServiceError> {
        Deferred {
            Future { promise in
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func addUser(user: UserModel) -> AnyPublisher<Bool, FirebaseServiceError> {
        Deferred {
            Future { promise in
                let collection = self.db.collection(FirestoreCollections.users.name)
                
                collection.document(user.id).setData(user.toDictionary() ?? [:])
                promise(.success(true))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
