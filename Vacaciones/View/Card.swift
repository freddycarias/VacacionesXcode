//
//  Card.swift
//  Vacaciones
//
//  Created by Rene Carias on 30/01/24.
//

import SwiftUI

struct Card: View {
    @State var nombre: String
    @State var fechaSolicitud: String
    @State var hora: String


    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .frame(width: 20, height: 20)

                Spacer()

                VStack {
                    Text(nombre)

                    Text(fechaSolicitud)
                }

                Spacer()

                Text(hora + "Hrs")
                
//                if estado == "aceptada" {
//                    Image(systemName: "hand.thumbsup.fill")
//                        .padding(.trailing, 30)
//                        .foregroundColor(Color.green)
//                        .offset(x: 40)
//
//                } else if estado == "rechazada"{
//                    Image(systemName: "hand.thumbsdown.fill")
//                        .padding(.trailing, 30)
//                        .foregroundColor(Color.red)
//                        .offset(x: 40)
//                } else {
//                    Image(systemName: "eye")
//                        .padding(.trailing, 30)
//                        .foregroundColor(Color.yellow)
//                        .offset(x: 40)
//                }

                Spacer()
            }
            
                .swipeActions(edge: .leading) {
                    Button {
                    } label: {
                        Label("Aprovado", systemImage: "hand.thumbsup")
                    }
                    .tint(.green)
                }
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(nombre: "David", fechaSolicitud: "233", hora: "0")
    }
}
