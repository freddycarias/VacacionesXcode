//
//  UserInfo.swift
//  Vacaciones
//
//  Created by Freddy Carias on 19/02/24.
//

import Foundation

struct UserInfo: Codable {
    let id_usuario: String
    let nombre: String
    let departamento: String
    let rol: String
    let horas_disponibles: String
}
