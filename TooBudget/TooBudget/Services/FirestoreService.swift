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
    
    func getUser(id: String) -> AnyPublisher<UserModel, FirebaseServiceError> {
        Deferred {
            Future { promise in
                let collection = self.db.collection(FirestoreCollections.users.name).document(id)
                
                collection.getDocument { snapshot, error in
                    if let error = error {
                        print("Error: \(error)")
                        promise(.failure(.errorRetrievingTheUser))
                        return
                    }
                    
                    guard let snapshot = snapshot,
                          let dictionary = snapshot.data() else {
                        promise(.failure(.errorRetrievingTheUser))
                        return
                    }
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(UserModel.self, from: jsonData)
                        
                        promise(.success(user))
                    } catch {
                        CrashlyticsService.logError(error)
                        promise(.failure(FirebaseServiceError.decodeUser))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
