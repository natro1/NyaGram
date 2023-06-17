//
//  LoggedInView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 12/05/2023.
//

import SwiftUI
import Firebase

struct LoggedInView: View {
    
    @ObservedObject private var viewModel: LoggedInViewModel
    
    init(viewModel: LoggedInViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            NyaColors.white.swiftUIColor
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack {
                        if viewModel.selectedImage != nil {
                            Text("Test@test.com")
                                .accentColor(NyaColors.darkPurple.swiftUIColor)
                                .fontWeight(.bold)
                            Image(uiImage: viewModel.selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .border(.white, width: 10)
                        } else {
                            Text(NyaStrings.dontBeShyText)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 25, weight: .semibold))
                                .padding(30)
                                .foregroundColor(NyaColors.darkPurple.swiftUIColor)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                }
                .padding(.bottom, 30)
                HStack {
                    NyaButtonView(viewModel: viewModel.photoButtonVM)
                    Spacer()
                        .frame(width: 30)
                    NyaButtonView(viewModel: viewModel.libraryButtonVM)
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(NyaStrings.nyaGram)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(NyaColors.white.swiftUIColor)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.logOut()
                        
                    }) {
                        Text(NyaStrings.logout)
                            .foregroundColor(NyaColors.white.swiftUIColor)
                            .font(.system(size: 15))
                    }
                }
            }
            .sheet(isPresented: $viewModel.isImagePickerDisplayed) {
                ImagePickerView(
                    selectedImage: $viewModel.selectedImage,
                    sourceType: viewModel.sourceType
                )
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(NyaColors.darkBlue.swiftUIColor, for: .navigationBar)
        }
    }
    
    struct LoggedInView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                LoggedInView(viewModel: .init(path: .constant([])))
            }
        }
    }
}
