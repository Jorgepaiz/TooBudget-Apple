//
//  LandingView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

struct LandingView: View {
    @Bindable private var viewModel: LandingViewModel
    
    init(_ viewModel: LandingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ImageSliderView(
                    images: [
                        "Landing",
                        "Landing2",
                        "Landing3",
                        "Landing4",
                        "Landing5"
                    ],
                    height: Constants.scrnPercForSlider(geometry)
                )
                TitleAndSubtitleView(
                    title: "landing_title",
                    subtitle: "landing_subtitle",
                    maxWidth: Constants.scrnPercForTitle(geometry)
                )
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                // main buttons
                HStack(spacing: 30) {
                    Button("btn_sign_in") {}
                    Button("btn_sign_up") {}
                }
                .buttonStyle(PrincipalButtonStyle())
                .padding(.horizontal, Constants.mainHorizontalPadding)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                // social media
                SocialMediaAccessView()
                    .padding(.horizontal, Constants.mainHorizontalPadding)
                
                Spacer()
                
                // version
                VersionBuildView()
                    .padding(.horizontal, Constants.mainHorizontalPadding)
            }
        }
        .background(.backdrop.gradient)
        .background(.white)
        .sheet(isPresented: $viewModel.sheetOfSignInView) {}
        .sheet(isPresented: $viewModel.sheetOfSignUpView) {}
        .sheet(isPresented: $viewModel.sheetOfForgotView) {}
        .fullScreenCover(isPresented: $viewModel.showActivityIndicator) {}
    }
}

#Preview {
    LandingView(LandingViewModel(LandingCoordinator(AppCoordinator())))
//        .environment(\.locale, Locale(identifier: "es"))
}
