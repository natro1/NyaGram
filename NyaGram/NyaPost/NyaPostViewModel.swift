//
//  NyaPostViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 19/06/2023.
//

import UIKit

class NyaPostViewModel: ObservableObject {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}
