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
                        Text("Test@test.com")
                            .accentColor(NyaColors.darkPurple.swiftUIColor)
                            .fontWeight(.bold)
                        Image("testImage")
                            .border(.white, width: 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    VStack {
                        Text("Test@test.com")
                            .accentColor(NyaColors.darkPurple.swiftUIColor)
                            .fontWeight(.bold)
                        Image("testImage")
                            .border(.white, width: 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                }
                .padding(.bottom, 30)
//                Button(action: {
//
//                }, label: {
//                    Text("Add a photo")
//                })
//                .padding(10)
//                .border(.green)
                NyaButtonView(viewModel: viewModel.photoButtonVM)
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
