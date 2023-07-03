//
//  LoggedInViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 14/05/2023.
//

import Combine
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class LoggedInViewModel: ObservableObject {
    
    @Binding private var path: [Screens]
    @Published var selectedImage: UIImage?
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var isPickerDisplayed = false
    @Published var retrievedImages = [UIImage]()
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
                self.service.uploadPhoto(image: newImage) {
                    self.loadImages()
                }
            }
        }.store(in: &anyCancellable)
    }
    
    func loadImages() {
        service.fetchPhotos { imageArray in
            DispatchQueue.main.async {
                self.retrievedImages = imageArray
                print("Load images: \(self.retrievedImages.count)")
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
