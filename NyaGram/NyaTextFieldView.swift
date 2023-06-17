//
//  TextFieldView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 10/05/2023.
//

import SwiftUI

struct NyaTextFieldView: View {
    
    @ObservedObject private var viewModel: NyaTextFieldViewModel
    
    init(viewModel: NyaTextFieldViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.isSecured {
            SecureField(viewModel.title, text: $viewModel.text)
                .placeholder(when: viewModel.text.isEmpty, placeholder: {
                    Text(viewModel.title).foregroundColor(NyaColors.lightPurple.swiftUIColor)
                })
                .foregroundColor(NyaColors.darkBlue.swiftUIColor)
                .padding()
                .background(NyaColors.white.swiftUIColor)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(NyaColors.darkBlue.swiftUIColor, style: StrokeStyle(lineWidth: 1.0)))
                .onSubmit {
                    viewModel.onSubmit()
                }
        } else {
            TextField("", text: $viewModel.text)
                .placeholder(when: viewModel.text.isEmpty) {
                    Text(viewModel.title).foregroundColor(NyaColors.lightPurple.swiftUIColor)
                }
                .foregroundColor(NyaColors.darkBlue.swiftUIColor)
                .padding()
                .background(NyaColors.white.swiftUIColor)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(NyaColors.darkBlue.swiftUIColor, style: StrokeStyle(lineWidth: 1.0)))
                .onSubmit {
                    viewModel.onSubmit()
                }
        }
    }
}

struct LoginTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NyaTextFieldView(viewModel: .init(title: "test", isSecured: false, text: .constant(""), onSubmit: {}))
            .padding()
    }
}
