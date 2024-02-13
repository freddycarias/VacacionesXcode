//
//  RequestViewModel.swift
//  Vacaciones
//
//  Created by Rene Carias on 1/02/24.
//

import Foundation
import SwiftUI

final class RequestViewModel: ObservableObject {
    @Published var requestModels: [RequestModel] = []
    
    func postLogin(correo: String, pass: String) {
        let endpoint = "https://servicios.tvguatesa.com/api/api/getInfoUsuario"

        guard let url = URL(string: endpoint) else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "correo": correo,
            "pass": pass
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, _, error  in
            guard let data = data , error == nil else{
                return
            }

            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("funciono \(response)")
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func getRequest(endPoint: String) async throws {
        let endpoint = endPoint

        guard let url = URL(string: endpoint) else {
            throw RMError.invalidURL
        }

        let request = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let response = response as? HTTPURLResponse, response.statusCode <= 300 else {
                throw RMError.invalidResponse
            }

            let jsonString = String(data: data, encoding: .utf8)
            print("Respuesta de la API: \(jsonString ?? "")")

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let lista = try decoder.decode(Solicitud.self, from: data)

            DispatchQueue.main.async {
                self.requestModels = lista.solicitud ?? []
            }
        } catch {
            throw RMError.invalidData
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }

    func sendRequest(idTipoValue: Int, dateNow: Date, startDate: Date, endDate: Date, hours: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://servicios.tvguatesa.com/api/api/postSolicitud") else {
            print("Error: URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData: [String: Any] = [
            "id_tipo": idTipoValue,
            "id_estado": 1,
            "fecha_solicitud": dateFormatter.string(from: dateNow),
            "fecha_inicio": dateFormatter.string(from: startDate),
            "fecha_fin": dateFormatter.string(from: endDate),
            "horas": hours,
            "id_usuario": 1,
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Error al realizar la solicitud: \(error.localizedDescription)")
                } else if let data = data {
                    // Operaciones que actualizan la interfaz de usuario
                    DispatchQueue.main.async {
                        print("Respuesta del servidor: \(String(data: data, encoding: .utf8) ?? "")")

                        completion(true)
                    }
                }
            }.resume()
        } catch {
            print("Error al convertir datos a JSON: \(error.localizedDescription)")
        }
    }
    
    func updateState(idEstado: String, idSolicitud: String) {
        
        guard let url = URL(string: "https://servicios.tvguatesa.com/api/api/updateEstadoSolicitud") else {
            print("Error: URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData: [String: Any] = [
              "id_estado": idEstado,
              "id_solicitud":idSolicitud
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Error al realizar la solicitud: \(error.localizedDescription)")
                } else if let data = data {
                    // Operaciones que actualizan la interfaz de usuario
                    DispatchQueue.main.async {
                        print("Respuesta del servidor: \(String(data: data, encoding: .utf8) ?? "")")
                    }
                }
            }.resume()
        } catch {
            print("Error al convertir datos a JSON: \(error.localizedDescription)")
        }
    }
    
    
    func updateAvailableHours(idUsuario: String, horasDisponibles: String) {
        
        guard let url = URL(string: "https://servicios.tvguatesa.com/api/api/updateHorasUsuario") else {
            print("Error: URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData: [String: Any] = [
              "id_usuario": "1",
              "horas_disponibles": horasDisponibles

        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error al realizar la solicitud: \(error.localizedDescription)")
                } else if let data = data {
                    DispatchQueue.main.async {
                        print("Respuesta del servidor: \(String(data: data, encoding: .utf8) ?? "")")
                    }
                }
            }.resume()
        } catch {
            print("Error al convertir datos a JSON: \(error.localizedDescription)")
        }
    }
}
