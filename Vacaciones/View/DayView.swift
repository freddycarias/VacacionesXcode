//
//  DayView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI

struct DayView: View {
    @StateObject private var requestViewModel = RequestViewModel()
    @StateObject private var postViewModel = PostViewModel()
    @State var typeData: String
    var body: some View {
        VStack {
            if userRol != "gerente" {
                List {
                    ForEach(postViewModel.requestModelsPlaning, id: \.self) { request in
                        if request.estado == "aceptada" {
                            Card(
                                nombre: request.nombre ?? "",
                                fechaSolicitud: request.fechaSolicitud?.formatDate() ?? "",
                                hora: request.horas ?? ""
                            )
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            } else {
                List {
                    ForEach(requestViewModel.requestModels, id: \.self) { request in
                        if request.estado == "aceptada" {
                            Card(
                                nombre: request.nombre ?? "df",
                                fechaSolicitud: request.fechaSolicitud?.formatDate() ?? "df",
                                hora: request.horas ?? "0"
                            )
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .task {
            if userRol != "gerente" {
                do {
                    if typeData == "day" {
                            postViewModel.postDaysId(idUsuario: userID, endpoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesUsuarioDay")
                    } else if typeData == "week" {
                            postViewModel.postDaysId(idUsuario: userID, endpoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesUsuarioWeek")
                    } else {
                            postViewModel.postDaysId(idUsuario: userID, endpoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesUsuarioMonth")
                    }
                }
            } else {
                do {
                    if typeData == "day" {
                        try await requestViewModel.getRequest(endPoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesHoy")
                    } else if typeData == "week" {
                            try await requestViewModel.getRequest(endPoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesBySemana")
                    } else {
                        try await requestViewModel.getRequest(endPoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesByMonth")
                    }
                } catch RMError.invalidURL {
                    print("Invalid URL")
                } catch RMError.invalidData {
                    print("Invalid Data")
                } catch RMError.invalidResponse {
                    print("Invalid Response")
                } catch {
                    print("Unexpected Error")
                }
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(typeData: "day")
    }
}
