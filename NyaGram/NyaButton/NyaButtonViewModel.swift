//
//  NyaButtonViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 13/05/2023.
//

import SwiftUI

class NyaButtonViewModel: ObservableObject {
    var title: String?
    var imageName: String?
    var action: (() -> Void)?
    
//    init(title: String?, image: UIImage?) {
//        self.title = title
//        self.image = image
//    }
    
    init(title: String) {
        self.title = title
//        self.image = nil
    }
    
    init(imageName: String) {
        self.imageName = imageName
//        self.title = nil
    }
}
