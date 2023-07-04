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
    
    func uploadImage(image: UIImage?, completion: @escaping () -> Void) {
        let path = "images/\(image.hashValue).jpg"
        guard let safeImage = image else { return }
        guard let imageData = safeImage.jpegData(
            compressionQuality: 0.8
        ) else { return }
        let fileRef = storageRef.child(path)
        _ = fileRef.putData(imageData) { metadata, error in
            if error == nil && metadata != nil {
                let database = Firestore.firestore()
                database.collection(NyaStrings.images).document().setData(
                    [
                        NyaStrings.url: path,
                        NyaStrings.username: getCurrentUserEmail()
                    ]
                ) { error in
                    if error == nil {
                        completion()
                    }
                }
            }
        }
    }
    
    func getCurrentUserEmail() -> String {
        if let username = Auth.auth().currentUser?.email {
            return username
        } else {
            return ""
        }
    }
    
    func fetchPostData(completion: @escaping ([Post]) -> Void) {
        var postArray = [Post]()
        let group = DispatchGroup()
        let database = Firestore.firestore()
        database.collection(NyaStrings.images).getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                for doc in snapshot!.documents {
                    if let url = doc[NyaStrings.url] as? String,
                       let username = doc[NyaStrings.username] as? String {
                        group.enter()
                        downloadImage(firebaseURL: url) {
                            guard let image = $0 else { return }
                            postArray.append(Post(image: image, username: username))
                            group.leave()
                        }
                    }
                }
                group.notify(queue: .main) {
                    completion(postArray)
                }
            } else {
                completion(postArray)
            }
        }
    }
    
    private func downloadImage(
        firebaseURL: String,
        completion: @escaping (UIImage?) -> Void
    ) {
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
