//
//  HeaderView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI

struct HeaderView: View {
    var text: String

    var body: some View {
        ZStack {
            backgroundView
            content
        }
        .foregroundColor(.white)
    }

    private var backgroundView: some View {
        Color(.orange)
            .frame(width: 400, height: 140)
    }

    private var content: some View {
        HStack {
            Spacer()

            Text(text)
                .fontWeight(.bold)

            Spacer()

            Button(action: {
                userID = ""
                userNombre = ""
                userDepartamento = ""
                userRol = ""
            }) {
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "power")
                }
            }
            .padding(.trailing, 15)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(text: "Agregar a mis contactos")
    }
}
