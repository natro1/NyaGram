//
//  ContentView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 10/05/2023.
//

import SwiftUI

struct LogInView: View {
    
    @ObservedObject private var viewModel: LogInViewModel
    
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            NyaColors.white.swiftUIColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                NyaTextFieldView(
                    viewModel: .init(
                        title: NyaStrings.email,
                        isSecured: false,
                        text: $viewModel.email,
                        onSubmit: {}
                    )
                )
                    .padding(.top, 80)
                NyaTextFieldView(
                    viewModel: .init(
                        title: NyaStrings.password,
                        isSecured: true,
                        text: $viewModel.password,
                        onSubmit: {
                            self.viewModel.login()
                        }
                    )
                )
                Text(viewModel.errorLabelText)
                    .foregroundColor(.red)
                    .opacity(viewModel.showError ? 1 : 0)
                NyaButtonView(viewModel: viewModel.loginButtonVM)
                    .padding(.top, 30)
                Spacer()
                Text(NyaStrings.noAccountText)
                    .foregroundColor(NyaColors.darkBlue.swiftUIColor)
                    .font(.system(size: 25))
                NyaButtonView(viewModel: viewModel.registerButtonVM)
                Spacer()
            }
            .padding(.horizontal, 30)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(NyaStrings.nyaGram)
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(NyaColors.white.swiftUIColor)
                }
            }
            .toolbarBackground(NyaColors.darkBlue.swiftUIColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onDisappear {
            viewModel.email = ""
            viewModel.password = ""
            viewModel.showError = false
        }
    }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LogInView(viewModel: .init(path: .constant([])))
        }
}
