//
//  SwiftUIView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI

struct VacationView: View {
    var body: some View {
        VStack {
            TabView {
                StartView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Inicio")
                    }
                
                if userRol != "gerente" {
                    NewRequestView()
                        .tabItem {
                            Image(systemName: "note.text.badge.plus")
                            Text("Solicitar")
                        }
                }
                
                ConsultView()
                    .tabItem {
                        Image(systemName: "rectangle.and.text.magnifyingglass")
                        Text("Consultar")
                    }
            }
            .padding(.top, -12)
        }
    }
}

struct VacationView_Previews: PreviewProvider {
    static var previews: some View {
        VacationView()
    }
}

