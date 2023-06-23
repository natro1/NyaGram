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
    
    init(title: String) {
        self.title = title
    }
    
    init(imageName: String) {
        self.imageName = imageName
    }
}
