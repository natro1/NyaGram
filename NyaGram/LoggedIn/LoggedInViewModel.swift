//
//  LoggedInViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 14/05/2023.
//

import SwiftUI
import Firebase

class LoggedInViewModel: ObservableObject {
    
    @Binding private var path: [Screens]
    @Published var selectedImage: UIImage?
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var isImagePickerDisplayed = false
    var photoButtonVM = NyaButtonViewModel(imageName: NyaStrings.camera)
    var libraryButtonVM = NyaButtonViewModel(imageName: NyaStrings.photo)
    
    init(path: Binding<[Screens]>) {
        self._path = path
        photoButtonVM.action = {
            self.sourceType = .camera
            self.isImagePickerDisplayed.toggle()
        }
        libraryButtonVM.action = {
            self.sourceType = .photoLibrary
            self.isImagePickerDisplayed.toggle()
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            path = []
        } catch {
            print("Error: \(error)")
        }
    }
}
