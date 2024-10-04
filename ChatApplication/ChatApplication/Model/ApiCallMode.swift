//
//  ApiCallMode.swift
//  ChatApplication
//
//  Created by NAM on 04/10/24.
//

import Foundation


struct ApiResponseModel: Codable {
    let users: [UserModel]?
}

struct UserModel: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let age: Int
    let gender: String
    let phone: String
    let image: String
}









