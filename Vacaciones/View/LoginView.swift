//
//  ContentView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

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
    @State private var showAlert = false

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
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Campos vacíos"), message: Text("Por favor ingresa tu correo y contraseña"), dismissButton: .default(Text("OK")))
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
            if validateFields() {
                requestViewModel.postLogin(correo: email, pass: password)
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    navigateToContacts = true
                }
            } else {
                showAlert = true
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
    
    private func validateFields() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
}















//{
//  "correo":"sbs.jbarrera@gmail.com",
//  "pass":"jhon123"
//}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
