//
//  Request.swift
//  Vacaciones
//
//  Created by Rene Carias on 30/01/24.
//

import SwiftUI

enum RequestType: String, CaseIterable, Identifiable {
    case request = "Solicitud"
    case planning = "Planeacion"
    var id: RequestType { self }
}

struct RequestView: View {
    @State var estado: String
    @State var nombre: String
    @State var tipoSolicitud: String
    @State var fechaSolicitud: String
    @State var hora: String
    @State var idSolicitud: String
    @State var horasDisponibles: String
    @StateObject private var requestViewModel = RequestViewModel()

    @State private var selectedCategory: RequestType = .request

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 90, height: 90)
                VStack {
                    Text("\(nombre)")

                    Text(" Desarrollo (department) ")

                    Text("Horas Disponibles: \(horasDisponibles)")
                    Text(idSolicitud)
                }
            }

            Picker("Tipo de Solicitud", selection: $selectedCategory) {
                ForEach(RequestType.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 300)

            if selectedCategory == .request {
               Text(tipoSolicitud)
                    .font(.largeTitle)
                    .padding(.vertical, 10)
            } else if selectedCategory == .planning {
                Text("Datos específicos para Planeacion")
                    .font(.largeTitle)
                    .padding(.vertical, 10)
            }

            Text("Fecha: \(fechaSolicitud)")
                .font(.largeTitle)
            Text("Horas: \(hora)hrs")
                .font(.largeTitle)

            Spacer()

            //if donde se valide que en el login el usuario sea gerente o colavorador
            if estado == "publicada" {
                Button(action: {
                    requestViewModel.updateState(idEstado: "2", idSolicitud: idSolicitud)
                }) {
                    Text("Aceptar")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 85)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                Button(action: {
                    requestViewModel.updateState(idEstado: "3", idSolicitud: idSolicitud)
                }) {
                    Text("Rechazar")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 80)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
        .padding(.top, -100)
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView(estado: "publicada", nombre: "Juan", tipoSolicitud: "vacaiones", fechaSolicitud: "25/03/2024", hora: "4", idSolicitud: "1", horasDisponibles: "120")
    }
}

//Buenas tardes

