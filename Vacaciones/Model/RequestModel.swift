//
//  RequestModel.swift
//  Vacaciones
//
//  Created by Rene Carias on 30/01/24.
//

import Foundation


struct Solicitud: Codable {
    var solicitud: [RequestModel]?
}

struct RequestModel: Codable, Hashable {
    let idSolicitud: String?
    let nombre: String?
    let horasDisponibles: String?
    let tipoSolicitud: String?
    var estado: String?
    let fechaSolicitud: String?
    let fechaInicio: String?
    let fechaFin: String?
    let horas: String?
    
    static let empty: RequestModel = .init(idSolicitud: "1", nombre: "sf", horasDisponibles: "", tipoSolicitud: "", fechaSolicitud: "", fechaInicio: "", fechaFin: "", horas: "")
}


enum RMError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
