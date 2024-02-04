//
//  SignUpView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import SwiftUI

struct SignUpView: View {
    @Bindable private var viewModel: SignUpViewModel
    @FocusState private var focusedField: SignUpViewModel.Fields?
    @Environment(\.dismiss) private var dissmis
    
    init(_ viewModel: SignUpViewModel) {
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
                            title: "sign_up_title",
                            subtitle: "sign_up_subtitle",
                            maxWidth: Constants.scrnPercForTitle(geometry)
                        )
                        
                        // main scroll
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: Constants.paddingBetweenSections) {
                                // form
                                VStack(spacing: 20) {
                                    TextField("", text: $viewModel.fullname)
                                        .textFieldStyle(
                                            TextFieldStyles(
                                                header: "full_name",
                                                iconName: "person",
                                                errorText: viewModel.errorFullname,
                                                isEmpty: viewModel.fullname.isEmpty,
                                                placeholder: "placeholder_fullname"
                                            )
                                        )
                                        .focused($focusedField, equals: .fullname)
                                        .autocorrectionDisabled()
                                        .textInputAutocapitalization(.words)
                                        .textContentType(.name)
                                        .submitLabel(.next)
                                    
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
                                    
                                    Button("btn_sign_up_create_account") {}
                                        .buttonStyle(PrincipalButtonStyle())
                                        .padding(.top, 10)
                                }
                                .onSubmit {
                                    switch focusedField {
                                    case .fullname:
                                        focusedField = .email
                                    case .email:
                                        focusedField = .password
                                    default:
                                        break
                                    }
                                }
                                
                                // have ccout
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
    SignUpView(SignUpViewModel(LandingViewModel(LandingCoordinator(AppCoordinator()))))
        .environment(\.locale, Locale(identifier: "es"))
}
