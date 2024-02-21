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


struct RequestModel2: Codable, Hashable {
    let id_solicitud: String?
    let nombre: String?
    let horas_disponibles: String?
    let tipo_solicitud: String?
    var id_estado: String?
    let fecha_solicitud: String?
    let fecha_inicio: String?
    let fecha_fin: String?
    let horas: String?
    
    static let empty: RequestModel2 = .init(id_solicitud: "", nombre: "", horas_disponibles: "", tipo_solicitud: "", fecha_solicitud: "", fecha_inicio: "", fecha_fin: "", horas: "")
}

enum RMError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
