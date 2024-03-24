//
//  UserModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import Foundation
import SwiftUI

struct UserDataModel: Decodable {
    let error: String
    let message: String
    let data: [UserPostModel]
}

struct UserPostModel: Decodable{
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let role: String
}
