//
//  ContentView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var nombre: String = ""
    @State private var requestViewModel = RequestViewModel()
    @State private var navigateToContacts = false
    static let customColor = Color(.orange)

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 45)

                VStack {
                    loginContent
                }

                loginButton
                
                Spacer()
                HStack {
                    Text("You don't have an account")
                    NavigationLink(destination: VacationView()) {
                        Text("Register")
                            .foregroundColor(LoginView.customColor)
                    }
                }
            }
        }
    }

    private var loginContent: some View {
        VStack(alignment: .leading) {
            TextCustomizer.customText("User Name")
            TextCustomizer.customTextField("UserName", text: $email, isEmail: true)

            TextCustomizer.customText("Password")
            TextCustomizer.customTextField("Password", text: $password, isPassword: true)
        }
    }

    private var loginButton: some View {
        Button(action: {
            requestViewModel.postLogin(correo: email, pass: password)

            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                navigateToContacts = true
            }

        }) {
            Text("Ingresar")
                .padding(.horizontal, 40)
        }
        .buttonStyle(.borderedProminent)
        .tint(LoginView.customColor)
        .foregroundColor(.white)
        .padding()
        .navigationDestination(
            isPresented: $navigateToContacts) {
                VacationView().navigationBarBackButtonHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
