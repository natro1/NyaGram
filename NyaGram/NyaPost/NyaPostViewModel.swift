//
//  NyaPostViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 19/06/2023.
//

import UIKit

class NyaPostViewModel: ObservableObject {
    
    var image: UIImage
    var username: String
    
    init(image: UIImage, username: String) {
        self.image = image
        self.username = username
    }
}
