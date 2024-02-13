//
//  RequestView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI

enum NewRequestType: String, CaseIterable, Identifiable {
    case holidays = "Vacaciones"
    case permissions = "Permiso"
    var id: NewRequestType { self }
}

struct NewRequestView: View {
    @State private var hours = 0
    @State private var selectedCategory: NewRequestType = .holidays
    @State var currentDate: Date = Date()

    @State private var selectedDates: Set<DateComponents> = []
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var dateNow = Date.now
    @State private var navigateToHome = false
    @State private var requestViewModel = RequestViewModel()
    

    var bounds: Range<Date> {
        return startDate ..< endDate
    }

    var body: some View {
        VStack {
            HeaderView(text: "Nueva Solicitud")
                .padding(.top, -60)

            VStack {
                Form {
                    Section {
                        Picker("Tipo de Solicitud", selection: $selectedCategory) {
                            ForEach(NewRequestType.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                    .padding()
                    .border(.gray, width: 2)

                    Section {
                        VStack {
                            DatePicker("Inicio", selection: $startDate, displayedComponents: [.date])

                            DatePicker("Fin", selection: $endDate, displayedComponents: [.date])

                            Spacer()

                            Divider()
                                .overlay(.black)

                            HStack {
                                Spacer()
                                VStack {
                                    Text("Fecha inicio:")
                                    Text(startDate, style: .date)
                                        .bold()
                                        .frame(width: 120)
                                }

                                Spacer()

                                VStack {
                                    Text("Fecha final:")
                                    Text(endDate, style: .date)
                                        .bold()
                                        .frame(width: 120)
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .border(.gray, width: 2)
                    
                    Section {
                        hoursContent
                        
                    }
                    .padding()
                    .border(.gray, width: 2)
                    
                }
                .scrollContentBackground(.hidden)
            }
            
            .padding(.top, -12)
            
            
            loginButton
        }
        
    }

    private var hoursContent: some View {
        VStack(alignment: .leading) {
            TextCustomizer.customText("Horas")

            TextField("number", text: Binding(
                get: { String(hours) },
                set: { hours = Int($0) ?? 0 }
            ))
            .padding()
            .frame(width: 280, height: 50)
            .background(Color.black.opacity(0.10))
            .cornerRadius(10)
        }
    }

    
    private var loginButton: some View {
        Button(action: {
            sendRequest()
        }) {
            Text("Solicitar")
                .padding(.horizontal, 40)
        }
        .buttonStyle(.borderedProminent)
        .tint(LoginView.customColor)
        .foregroundColor(.white)
        .padding()
        .background(
            NavigationLink(
                destination: VacationView().navigationBarBackButtonHidden(true),
                isActive: $navigateToHome,
                label: { EmptyView() }
            )
        )
    }
    
    
    private func sendRequest() {
        let idTipoValue: Int = selectedCategory.rawValue == "Vacaciones" ? 1 : 2
        requestViewModel.sendRequest(idTipoValue: idTipoValue,
                                     dateNow: dateNow,
                                     startDate: startDate,
                                     endDate: endDate,
                                     hours: hours) { success in
            if success {
                requestViewModel.updateAvailableHours(idUsuario: "1", horasDisponibles: "110")
                // El envío de datos fue exitoso, ahora puedes navegar a otra vista
                navigateToHome = true
            } else {
                // El envío de datos falló, puedes manejarlo según sea necesario
                print("Error en el envío de datos.")
            }
        }
    }
}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        NewRequestView()
    }
}
