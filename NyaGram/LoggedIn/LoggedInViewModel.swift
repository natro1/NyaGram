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
    var photoButtonVM = NyaButtonViewModel(title: "Add a photo")
    
    init(path: Binding<[Screens]>) {
        self._path = path
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
