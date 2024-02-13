//
//  UserModel.swift
//  Vacaciones
//
//  Created by Rene Carias on 1/02/24.
//

import Foundation

struct UserModel: Codable, Identifiable ,Hashable{
    let name: String
    let rol: String
    let department: String
    let email: String
    let password: String
    let id: String
    var hours: Int

    init(
        id: String = UUID().uuidString,
        name: String,
        rol: String,
        department: String,
        email: String,
        password: String,
        hours: Int = 120
    ) {
        self.id = id
        self.name = name
        self.rol = rol
        self.department = department
        self.email = email
        self.password = password
        self.hours = hours
    }
}
