//
//  LandingView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI
import TipKit

struct LandingView: View {
    @Bindable private var viewModel: LandingViewModel
    
    init(_ viewModel: LandingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // main view
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
                        Button("btn_sign_in") { viewModel.showSignInView() }
                        //                        .popoverTip(favoriteLandmarkTip, arrowEdge: .top)
                        Button("btn_sign_up") { viewModel.showSignUpView() }
                        //                        .popoverTip(addAppIdeaTip, arrowEdge: .bottom)
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
                    
                    // version
                    VersionBuildView()
                        .padding(.horizontal, Constants.mainHorizontalPadding)
                }
                
                // notifications
                VStack {
                    Spacer()
                    
                    ToastView(
                        title: "Information",
                        message: "Custom message is long text to test capacity of the tip component."
                    )
                    
                    ToastView(
                        title: "Success",
                        message: "Custom message is long text to test capacity of the tip component.",
                        kind: .success
                    )
                    
                    ToastView(
                        title: "Warning",
                        message: "Custom message is long text to test capacity of the tip component.",
                        kind: .warning
                    )
                    
                    ToastView(
                        title: "Error",
                        message: "Custom message is long text to test capacity of the tip component.",
                        kind: .error
                    )
                }
                .padding(.horizontal)
            }
        }
        .background(.backdrop.gradient)
        .background(.white)
        .sheet(isPresented: $viewModel.signInSheet) {
            SignInView(SignInViewModel(viewModel))
        }
        .sheet(isPresented: $viewModel.signUpSheet) {
            SignUpView(SignUpViewModel(viewModel))
        }
        .sheet(isPresented: $viewModel.forgotSheet) {
            ForgotView(ForgotViewModel(viewModel))
        }
        .fullScreenCover(isPresented: $viewModel.modalSheet) {
            ActivityIndicator(message: viewModel.activityIndicatorMessage)
        }
        .onAppear() {
            viewModel.previousLogin()
        }
    }
}

#Preview {
    LandingView(LandingViewModel(LandingCoordinator(AppCoordinator())))
        .environment(\.locale, Locale(identifier: "es"))
        .task {
            try? Tips.resetDatastore()
            try? Tips.configure([
                .displayFrequency(.immediate),
//                .datastoreLocation(.applicationDefault)
            ])
        }
}
