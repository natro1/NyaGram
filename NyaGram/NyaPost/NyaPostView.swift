//
//  NyaPostView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 19/06/2023.
//

import SwiftUI

struct NyaPostView: View {

    @ObservedObject private var viewModel: NyaPostViewModel
    
    init(viewModel: NyaPostViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text(viewModel.username)
                .foregroundColor(NyaColors.darkPurple.swiftUIColor)
                .font(.system(size: 20, weight: .bold))
            Image(uiImage: viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(.white, width: 10)
                .padding(.top, 1)
                .padding(.bottom, 50)
        }
    }
}

struct NyaPostView_Previews: PreviewProvider {
    static var previews: some View {
        NyaPostView(viewModel: .init(image: .init(), username: "test"))
    }
}
