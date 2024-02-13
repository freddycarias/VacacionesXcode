//
//  DayView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI

struct DayView: View {
    @StateObject private var requestViewModel = RequestViewModel()
    @State var typeData: String
    var body: some View {
        VStack {
            List {
                ForEach(requestViewModel.requestModels, id: \.self) { request in
                    if request.estado == "aceptada" {
                        Card(
                            nombre: request.nombre ?? "df",
                            fechaSolicitud: request.fechaSolicitud?.formatDate() ?? "df",
                            hora: request.horas ?? "0",
                            estado: request.estado ?? ""
                        )
                    }
                }
            }

            .scrollContentBackground(.hidden)
        }
        .task {
            do {
                if typeData == "day" {
                    try await requestViewModel.getRequest(endPoint: "https://servicios.tvguatesa.com/api/api/getSolicitudesHoy"
                    )
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

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(typeData: "day")
    }
}



//private var contacts: [ContactModel] = [
//    .init(name: "Mario", phoneNumber: "4356 3413", email: "mario@gmail.com", bankDestination: "Banco Cuscatlán"),
//    .init(name: "Maria", phoneNumber: "3562 4623", email: "maria@gmail.com", bankDestination: "Banco Cuscatlán"),
//    .init(name: "Marta", phoneNumber: "9485 8484", email: "marta@gmail.com", bankDestination: "Banco Cuscatlán"),
//    .init(name: "Marlon", phoneNumber: "9385 8393", email: "marlon@gmail.com", bankDestination: "Banco Cuscatlán"),
//    .init(name: "Aron", phoneNumber: "9394 8584", email: "aron@gmail.com", bankDestination: "Banco Cuscatlán"),
//    .init(name: "Diago", phoneNumber: "9398 5824", email: "diago@gmail.com", bankDestination: "Banco Cuscatlán"),
//]
//
//var filteredContacts: [ContactModel] {
//    guard !searchTerm.isEmpty else { return contacts.sorted { $0.name < $1.name } }
//    return contacts.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
//}
//
//var groupedContacts: [String: [ContactModel]] {
//    Dictionary(grouping: filteredContacts, by: { String($0.name.prefix(1)) })
//}
//
//List {
//    ForEach(groupedContacts.keys.sorted(), id: \.self) { key in
//        Section(header: Text(key)) {
//            ForEach(groupedContacts[key]!, id: \.id) { contact in
//                NavigationLink(destination: AddNewContact(bankDestinationContact: contact.bankDestination, nameContact: contact.name, phoneNomberContact: contact.phoneNumber, emailContact: contact.email)){
//                    Text(contact.name)
//                }
//            }
//        }
//    }
//}
