//
//  LoggedInView.swift
//  NyaGram
//
//  Created by Natalia Rojek on 12/05/2023.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct LoggedInView: View {
    
    @StateObject var viewModel: LoggedInViewModel
    
    var body: some View {
        ZStack {
            NyaColors.white.swiftUIColor
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack {
                        ForEach(viewModel.retrievedImages, id: \.self) { image in
                            NyaPostView(viewModel: .init(image: image))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(40)
                .padding(.bottom, 30)
                HStack {
                    NyaButtonView(viewModel: viewModel.photoButtonVM)
                    Spacer()
                        .frame(width: 30)
                    NyaButtonView(viewModel: viewModel.libraryButtonVM)
                }
                Spacer()
            }
            .onAppear {
                viewModel.loadImages()
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
            .sheet(isPresented: $viewModel.isPickerDisplayed) {
                ImagePicker(
                    selectedImage: $viewModel.selectedImage,
                    isPickerDisplayed: $viewModel.isPickerDisplayed,
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
