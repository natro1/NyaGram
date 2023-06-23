//
//  NyaPostViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 19/06/2023.
//

import SwiftUI

class NyaPostViewModel: ObservableObject {
    
    @Published var images = [UIImage]()
    private let service = NyaGramService()

    func loadImages() {
        service.fetchPhotos { imageArray in
            DispatchQueue.main.async {
                self.images = imageArray
            }
        }
    }
}
