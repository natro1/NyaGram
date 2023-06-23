//
//  NyaPostView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 19/06/2023.
//

import SwiftUI

struct NyaPostView: View {

    @ObservedObject private var viewModel = NyaPostViewModel()
    
    init() {
        viewModel.loadImages()
    }

    var body: some View {
        VStack {
            ForEach(viewModel.images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .border(.white, width: 10)
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity)
    }
}

struct NyaPostView_Previews: PreviewProvider {
    static var previews: some View {
        NyaPostView()
    }
}
