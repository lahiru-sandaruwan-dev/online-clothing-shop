//
//  UserModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import Foundation
import SwiftUI

struct UserDataModel: Codable  {
    let error: Bool?
    let message: String?
    let data: UserPostModel
}

struct UserPostModel: Codable{
    let firstName: String
    let lastName: String
    let email: String
    let picture: String
    let password: String
    let role: String
    let mobile: String
    let address: String
}

struct UserLoginDataModel: Codable {
    let error: Bool?
    let message: String?
    let data: UserLoginModel
}

struct UserLoginModel: Codable {
    let email: String?
    let password: String?
    let token: String
    let role: String
    let userId: String
    
}

struct UDataModel: Codable  {
    let error: Bool?
    let message: String?
    let data: [UPostModel]
}

struct UPostModel: Hashable, Codable{
    let _id: String
    let firstName: String
    let lastName: String
    let email: String
    let picture: String
    let password: String
    let role: String
    let mobile: String
    let address: String
}
