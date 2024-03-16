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
            HStack {
                Spacer()
                Spacer()
                Button ("Budget") {
                    viewModel.goToBudget()
                }
                Spacer()
                Button("Logout") {
                    viewModel.logOut()
                }
                Spacer()
                Spacer()
            }
            .buttonStyle(.bordered)
        }
        .onAppear {
            AnalyticsService.currentScreenView(.home)
            viewModel.checkCurrentBudget()
        }
    }
}

#Preview {
    HomeView(HomeViewModel(HomeCoordinator(AppCoordinator())))
}
