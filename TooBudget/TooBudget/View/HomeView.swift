//
//  HomeView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct HomeView: View {
    @Bindable private var viewModel: HomeViewModel
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Home View")
            Button("Logout") {
                viewModel.logOut()
            }
            .buttonStyle(.bordered)
        }
        .onAppear() {
            Task {
                await viewModel.checkCurrentBudget()
            }
        }
    }
}

#Preview {
    HomeView(HomeViewModel(HomeCoordinator(AppCoordinator())))
}
