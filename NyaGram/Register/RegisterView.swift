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
                    NyaTextFieldView(viewModel: .init(title: "Email", isSecured: false, text: $viewModel.email))
                    NyaTextFieldView(viewModel: .init(title: "Password", isSecured: true, text: $viewModel.password))
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
                    Text("Register")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(NyaColors.white.swiftUIColor)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.goToRoot()
                    }) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(NyaColors.white.swiftUIColor)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(NyaColors.darkBlue.swiftUIColor, for: .navigationBar)
//        .navigationDestination(isPresented: $viewModel.showNextScreen, destination: {
//            LoggedInView()
//        })
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
