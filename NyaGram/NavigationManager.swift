//
//  NavigationManager.swift
//  NyaGram
//
//  Created by Natalia Rojek on 18/05/2023.
//

import SwiftUI

struct NavigationManager: View {
    
    @State private var path = [Screens]()
    
    var body: some View {
        NavigationStack(path: $path) {
            LogInView(viewModel: .init(path: $path))
                .navigationDestination(for: Screens.self) { screen in
                    switch screen {
                    case .loggedInView:
                        LoggedInView(viewModel: .init(path: $path))
                    case .registerView:
                        RegisterView(viewModel: .init(path: $path))
                    case .logInView:
                        LogInView(viewModel: .init(path: $path))
                    }
                }
        }
    }
}

enum Screens {
    case registerView
    case logInView
    case loggedInView
}
