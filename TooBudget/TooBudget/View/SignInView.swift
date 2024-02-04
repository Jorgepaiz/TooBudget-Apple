//
//  SignInView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/3/24.
//

import SwiftUI

struct SignInView: View {
    @Bindable private var viewModel: SignInViewModel
    @FocusState private var focusedField: SignInViewModel.Fields?
    @Environment(\.dismiss) private var dissmis
    
    init(_ viewModel: SignInViewModel) {
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
                            title: "sign_in_title",
                            subtitle: "sign_in_subtitle",
                            maxWidth: Constants.scrnPercForTitle(geometry)
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
                                        .focused($focusedField, equals: .email)
                                        .autocorrectionDisabled()
                                        .keyboardType(.emailAddress)
                                        .textContentType(.emailAddress)
                                        .submitLabel(.next)
                                    
                                    SecureField("", text: $viewModel.password)
                                        .textFieldStyle(
                                            TextFieldStyles(
                                                header: "password",
                                                iconName: "key",
                                                errorText: viewModel.errorPassword,
                                                isEmpty: viewModel.password.isEmpty,
                                                placeholder: "placeholder_password"
                                            )
                                        )
                                        .focused($focusedField, equals: .password)
                                        .autocorrectionDisabled()
                                        .textContentType(.password)
                                        .submitLabel(.done)
                                    
                                    HStack(spacing: 0) {
                                        Toggle(isOn: $viewModel.rememberMe, label: { Text("remember_me") })
                                            .toggleStyle(CheckBoxToggleStyle())
                                        
                                        Spacer()
                                        
                                        Button("btn_forgot_password") { viewModel.showForgotView() }
                                            .buttonStyle(TextButtonStyle())
                                    }
                                    
                                    Button("btn_sign_in_access") { }
                                        .buttonStyle(PrincipalButtonStyle())
                                        .padding(.top, 10)
                                }
                                .onSubmit {
                                    switch focusedField {
                                    case .email:
                                        focusedField = .password
                                    default:
                                        break
                                    }
                                }
                                
                                // have no accout
                                HaveAccountView(haveAccount: false, tapButton: viewModel.showSignUpView )
                                
                                // social media
                                SocialMediaAccessView()
                            }
                        }
                    }
                    .padding(.horizontal, Constants.mainHorizontalPadding)
                }
                .frame(
                    width: geometry.size.width,
                    height: Constants.scrnPercForSheet(geometry),
                    alignment: .center
                )
                .background(.backdrop.gradient)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: Constants.sheetCornerRadius))
            }
        }
        .presentationBackground(.clear)
        .ignoresSafeArea()
        .onDisappear() {
            dissmis()
        }
    }
}

#Preview {
    SignInView(SignInViewModel(LandingViewModel(LandingCoordinator(AppCoordinator()))))
        .environment(\.locale, Locale(identifier: "es"))
}
