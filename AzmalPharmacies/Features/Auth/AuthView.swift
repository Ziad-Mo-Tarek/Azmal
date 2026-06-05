//
//  AuthView.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 05/06/2026.
//

import SwiftUI

struct AuthView: View {
    enum AuthOptions: Hashable, CaseIterable {
        case login, signUp
        
        var title: String {
            switch self {
            case .login:
                "Log In"
            case .signUp:
                "Sign Up"
            }
        }
    }
    
    @State var selectedOption: AuthOptions = .login
    
    var pageTitle: String {
        if selectedOption == .login {
            return "Welcome Back !"
        } else {
            return "Create Your Account"
        }
    }
    var pageDesription: String {
        if selectedOption == .login {
            return "Log in and get back to your health needs"
        } else {
            return "Enjoy full app features by signing up"
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            LinearGradient(colors: [.primaryApp, .loginBackground], startPoint: .bottom, endPoint: .topTrailing)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 0){
                
                titleView
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                
                content
                    .ignoresSafeArea()
            }
            
            
        }
    }
    
    private var content: some View {
        ZStack {
            Color.appWhite
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 30){
                    segmentView
                        .padding(.horizontal, 69)
                        .padding(.top, 28)
                    
                    if selectedOption == .login {
                        LoginView()
                    } else {
                        RegisterView()
                    }
                    
                    alternativeLoginMethodsView
                        .padding(.top, -6)
                        
                }
                .appScreenPadding()
                .padding(.bottom, 50)
            }
            .scrollIndicators(.hidden)
        }
        .cornerRadius(36)
    }
    
    private var titleView: some View {
       VStack(alignment: .center, spacing: 0){
            Image(.logoCircle)
            
            VStack(alignment: .center, spacing: 4) {
                Text(LocalizedStringKey(pageTitle))
                    .appTextStyle(.headingSmall, color: .appWhite)
                Text(LocalizedStringKey(pageDesription))
                    .appTextStyle(.bodySmall, color: .appWhite)
            }
        }
    }
    
    private var segmentView: some View {
        SegmentedPicker(options: AuthOptions.allCases, selected: $selectedOption, label: { $0.title }) { newValue in
            selectedOption = newValue
        }
    }
    
    private var alternativeLoginMethodsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center, spacing: 4) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                Text(LocalizedStringKey(selectedOption == .login ? "Or Log In With" : "Or Sign Up With"))
                    .appTextStyle(.bodySemiboldSmall, color: .gray)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
            }
            .padding(.bottom, 8)
            
            socialLogin(icon: .googleIcon, name: "Google") {
                // TODO: Handle later
            }
        }
    }
    
    private func socialLogin(icon: ImageResource, name: String, onClicked: @escaping () -> ()) -> some View {
        Button {
            onClicked()
        } label: {
            HStack(spacing: 8){
                Image(icon)
                Text(LocalizedStringKey(name))
                    .appTextStyle(.bodySemiboldSmall, color: .appDark)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 15.5)
            .background(
                RoundedRectangle(cornerRadius: 23)
                .strokeBorder(.primaryApp, lineWidth: 0.3)
            )
        }

    }
    
}

#Preview {
    AuthView()
}
