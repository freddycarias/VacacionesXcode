//
//  StartView.swift
//  Vacaciones
//
//  Created by Rene Carias on 29/01/24.
//

import SwiftUI

struct StartView: View {
    @State private var selectedTab: Int = 0

    let tabs: [Tab] = [
        .init(title: "Hoy"),
        .init(title: "Semana"),
        .init(title: "Mes"),
    ]

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.white)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }

    var body: some View {
        VStack {
            HeaderView(text: "Vacaciones")
                .padding(.top, -60)

            NavigationView {
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        // Tabs
                        Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)

                        // Views
                        TabView(selection: $selectedTab,
                                content: {
                                    DayView(typeData: "day")
                                        .tag(0)
                                    DayView(typeData: "week")
                                        .tag(1)
                                    DayView(typeData: "month")
                                        .tag(2)
                                })
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
