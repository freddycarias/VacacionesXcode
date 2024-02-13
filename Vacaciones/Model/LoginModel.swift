//
//  LoginModel.swift
//  Vacaciones
//
//  Created by Rene Carias on 8/02/24.
//

import Foundation

struct LoginModel: Codable {
    let correo: String
    let pass: String
}

//struct Prueba: Codable {
//    let prueba : [Respuesta]
//}
//
struct Respuesta : Codable{
    let departamento: String
    let nombre: String
}
