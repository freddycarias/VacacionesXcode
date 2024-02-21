//
//  PostViewModel.swift
//  Vacaciones
//
//  Created by Freddy Carias on 19/02/24.
//

import Foundation
import SwiftUI

final class PostViewModel: ObservableObject {
    @Published var requestModelsPlaning: [RequestModel] = []

    func postDaysId(idUsuario: String, endpoint: String) {
        guard let url = URL(string: endpoint) else {
            print("Error: URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData: [String: Any] = [
            "id_usuario": idUsuario
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, _, error  in
            guard let data = data , error == nil else {
                return
            }
            print(data)
            do {
                let json = try JSON(data: data)
                let decoder = JSONDecoder()
                print("json" + "\(json.arrayValue)")
                self.requestModelsPlaning = try decoder.decode([RequestModel].self, from: json.rawData())
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
