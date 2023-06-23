//
//  NyaGramService.swift
//  NyaGram
//
//  Created by Natalia Rojek on 15/05/2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct NyaGramService {
    
    private let storageRef = Storage.storage().reference()
    private let path = "images/\(UUID().uuidString).jpg"

    func login(
        _ email: String,
        _ password: String,
        _ completion: @escaping (_ error: Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error != nil {
                return completion(error)
            } else {
                return completion(nil)
            }
        }
    }
    
    func register(
    _ email: String,
    _ password: String,
    _ completion: @escaping (_ error: Error?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error != nil {
                return completion(error)
            } else {
                return completion(nil)
            }
        }
    }
    
    func logOut(_ completion: @escaping (_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            return completion(nil)
        } catch {
            print("Error: \(error)")
            return completion(error)
        }
    }
    
    func uploadPhoto(image: UIImage?) {
        let storageRef = Storage.storage().reference()
        guard image != nil else { return }
        let imageData = image!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else { return }
        let fileRef = storageRef.child(path)
        _ = fileRef.putData(imageData!) { metadata, error in
            if error == nil && metadata != nil {
                let database = Firestore.firestore()
                database.collection(NyaStrings.images).document().setData([NyaStrings.url: path]) { error in
                    if error == nil {
                        
                    }
                }
            }
        }
    }
    
    func fetchPhotos(completion: @escaping ([UIImage]) -> Void) {
        var images = [UIImage]()
        let group = DispatchGroup()
        let database = Firestore.firestore()
        database.collection(NyaStrings.images).getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                var paths = [String]()
                for doc in snapshot!.documents {
                    // swiftlint:disable force_cast
                    paths.append(doc[NyaStrings.url] as! String)
                    // swiftlint:enable force_cast
                }
                for path in paths {
                    group.enter()
                    downloadImage(firebaseURL: path) {
                        guard let image = $0 else { return }
                        images.append(image)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    completion(images)
                }
            } else {
                completion(images)
            }
        }
    }
    
    private func downloadImage(
        firebaseURL: String,
        completion: @escaping (UIImage?) -> Void
    ) {
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(firebaseURL)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                if let image = UIImage(data: data!) {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
}
