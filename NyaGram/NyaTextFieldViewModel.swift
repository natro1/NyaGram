//
//  NyaTextFieldViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 14/05/2023.
//

import SwiftUI

class NyaTextFieldViewModel: ObservableObject {
    
    var title: String
    var isSecured: Bool
    @Binding var text: String
    
    init(title: String, isSecured: Bool, text: Binding<String>) {
        self.title = title
        self.isSecured = isSecured
        self._text = text
    }
    
}
