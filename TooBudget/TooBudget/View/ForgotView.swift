//
//  ForgotView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import SwiftUI

struct ForgotView: View {
    @Bindable private var viewModel: ForgotViewModel
    @Environment(\.dismiss) private var dissmis
    private let constants = Constants.shared
    
    init(_ viewModel: ForgotViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // to push the main VStack content to the bottom of the screen
                Spacer()
                
                // main content
                VStack(spacing: 0) {
                    CloseButtonView()
                    
                    // content
                    VStack(spacing: Constants.paddingBetweenSections) {
                        TitleAndSubtitleView(
                            title: "forgot_password_title",
                            subtitle: "forgot_password_subtitle",
                            maxWidth: constants.scrnPercForTitle(geometry)
                        )
                        
                        // main scroll
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: Constants.paddingBetweenSections) {
                                // form
                                VStack(spacing: 20) {
                                    TextField("", text: $viewModel.email)
                                        .textFieldStyle(
                                            TextFieldStyles(
                                                header: "email",
                                                iconName: "mail",
                                                errorText: viewModel.errorEmail,
                                                isEmpty: viewModel.email.isEmpty,
                                                placeholder: "placeholder_email"
                                            )
                                        )
                                        .autocorrectionDisabled()
                                        .keyboardType(.emailAddress)
                                        .textContentType(.emailAddress)
                                        .submitLabel(.next)
                                    
                                    Button("btn_forgot_password_send") {
                                        viewModel.validateForm()
                                    }
                                        .buttonStyle(PrincipalButtonStyle())
                                        .padding(.top, 10)
                                }
                                
                                // have no accout
                                HaveAccountView(tapButton: viewModel.showSignInView )
                                
                                // social media
                                SocialMediaAccessView()
                            }
                        }
                        
                    }
                    .padding(.horizontal, Constants.mainHorizontalPadding)
                }
                .frame(
                    width: geometry.size.width,
                    height: constants.scrnPercForSheet(geometry),
                    alignment: .center
                )
                .background(.backdrop.gradient)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: Constants.sheetCornerRadius))
            }
        }
        .presentationBackground(.clear)
        .ignoresSafeArea()
        .onAppear {
            AnalyticsService.specialScreenView("Forgot Password")
        }
        .onDisappear {
            dissmis()
        }
    }
}

#Preview {
    ForgotView(ForgotViewModel(LandingViewModel(LandingCoordinator(AppCoordinator()))))
        .environment(\.locale, Locale(identifier: "es"))
}
