//
//  ConsultView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI

enum ConsultType: String, CaseIterable, Identifiable {
    case accepted = "Aceptados"
    case rejected = "Rechazados"
    case published = "Publicados"
    var id: ConsultType { self }
}

struct ConsultView: View {
    @StateObject private var requestViewModel = RequestViewModel()

    @State private var selectedCategory: ConsultType = .accepted

    var body: some View {
        VStack {
            HeaderView(text: "Solicitudes")
                .padding(.top, -60)

            NavigationStack {
                VStack {
                    Picker("Tipo de Solicitud", selection: $selectedCategory) {
                        ForEach(ConsultType.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 300)

                    if selectedCategory == .accepted {
                        List {
                            ForEach(requestViewModel.requestModels.filter { shouldShowRequest($0) }, id: \.self) { request in

                                NavigationLink {
                                    getRequestView(for: request)
                                } label: {
                                    getCard(for: request)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .task {
                            do {
                                try await requestViewModel.getRequest(endPoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesAcepted")
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
                    } else if selectedCategory == .rejected {
                        List {
                            ForEach(requestViewModel.requestModels.filter { shouldShowRequest($0) }, id: \.self) { request in

                                NavigationLink {
                                    getRequestView(for: request)
                                } label: {
                                    getCard(for: request)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .task {
                            do {
                                try await requestViewModel.getRequest(endPoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesDeclined")
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
                    } else {
                        List {
                            ForEach(requestViewModel.requestModels.filter { shouldShowRequest($0) }, id: \.self) { request in

                                NavigationLink {
                                    getRequestView(for: request)
                                } label: {
                                    getCard(for: request)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .task {
                            do {
                                try await requestViewModel.getRequest(endPoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesPublished")
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
        }
    }

    func shouldShowRequest(_ request: RequestModel) -> Bool {
        switch selectedCategory {
        case .accepted:
            return request.estado == "aceptada"
        case .rejected:
            return request.estado == "rechazada"
        case .published:
            return request.estado == "publicada"
        }
    }

    func getCard(for request: RequestModel) -> some View {
        Card(
            nombre: request.nombre ?? "df",
            fechaSolicitud: request.fechaSolicitud?.formatDate() ?? "df",
            hora: request.horas ?? "0",
            estado: request.estado ?? "publicada"
        )
    }

    func getRequestView(for request: RequestModel) -> some View {
        RequestView(
            estado: request.estado ?? "publicada", nombre: request.nombre ?? "df",
            tipoSolicitud: request.tipoSolicitud ?? "vacaciones",
            fechaSolicitud: request.fechaSolicitud?.formatDate() ?? "df",
            hora: request.horas ?? "0", idSolicitud: request.idSolicitud ?? "1", horasDisponibles: request.horasDisponibles ?? "120"
        )
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self)
    }

    func formatDate() -> String {
        if let date = toDate() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return "Fecha inválida"
        }
    }
}

struct ConsultView_Previews: PreviewProvider {
    static var previews: some View {
        ConsultView()
    }
}
