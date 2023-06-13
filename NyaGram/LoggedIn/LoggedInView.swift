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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
