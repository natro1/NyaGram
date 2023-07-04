//
//  LoggedInViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 14/05/2023.
//

import Combine
import SwiftUI

class LoggedInViewModel: ObservableObject {
    
    @Binding private var path: [Screens]
    @Published var selectedImage: UIImage?
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var isPickerDisplayed = false
    @Published var retrievedPosts = [Post]()
    var photoButtonVM = NyaButtonViewModel(imageName: NyaStrings.camera)
    var libraryButtonVM = NyaButtonViewModel(imageName: NyaStrings.photo)
    private let service = NyaGramService()
    private var anyCancellable = Set<AnyCancellable>()
    
    init(path: Binding<[Screens]>) {
        self._path = path
        photoButtonVM.action = {
            self.sourceType = .camera
            self.isPickerDisplayed = true
        }
        libraryButtonVM.action = {
            self.sourceType = .photoLibrary
            self.isPickerDisplayed = true
        }
        $selectedImage.sink { newImage in
            if newImage != nil {
                self.service.uploadImage(image: newImage) {
                    self.loadPosts()
                }
            }
        }.store(in: &anyCancellable)
    }
    
    func loadPosts() {
        service.fetchPostData { postArray in
            print("posts\(postArray)")
            DispatchQueue.main.async {
                self.retrievedPosts = postArray
            }
        }
    }
         
    func logOut() {
        service.logOut { error in
            if error == nil {
                self.path = []
            }
        }
    }
}
