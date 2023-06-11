//
//  NyaButtonView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 10/05/2023.
//

import SwiftUI

struct NyaButtonView: View {
    @ObservedObject private var viewModel: NyaButtonViewModel
    
    init(viewModel: NyaButtonViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: {
            viewModel.action?()
        }) {
            Text(viewModel.title)
                .font(.system(size: 20))
                .foregroundColor(NyaColors.white.swiftUIColor)
                .fontWeight(.heavy)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(NyaColors.darkPurple.swiftUIColor)
                .cornerRadius(20)
        }
    }
}

struct NyaButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NyaButtonView(viewModel: .init(title: "test"))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
