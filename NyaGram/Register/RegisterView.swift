//
//  RegisterView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 11/05/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject private var viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
            ZStack {
                NyaColors.white.swiftUIColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    NyaTextFieldView(viewModel: .init(title: NyaStrings.email, isSecured: false, text: $viewModel.email))
                    NyaTextFieldView(viewModel: .init(title: NyaStrings.password, isSecured: true, text: $viewModel.password))
                    Text(viewModel.errorLabelText)
                        .foregroundColor(.red)
                        .opacity(viewModel.showError ? 1 : 0)
                    NyaButtonView(
                        viewModel: viewModel.signUpButtonVM
                    )
                }
                .padding(.horizontal, 30)
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(NyaStrings.register)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(NyaColors.white.swiftUIColor)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.goToRoot()
                    }) {
                        Image(systemName: NyaStrings.backwardArrow)
                            .foregroundColor(NyaColors.white.swiftUIColor)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(NyaColors.darkBlue.swiftUIColor, for: .navigationBar)
    }
    
    
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
//                RegisterView(
//                    viewModel: .init(
//                    )
//                )
            }
        }
    }
}
