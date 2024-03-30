//
//  UserSession.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-30.
//

import Foundation

class UserSession {
    static let shared = UserSession()
    
    var userId: String?
    var message: String?
    
    private init() {} // Private initializer to prevent multiple instances
}
