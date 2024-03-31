//
//  OrderModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-31.
//

import Foundation
import SwiftUI

struct OrderModel: Codable {
    let isSuccessful: Bool
    let code: Int
    let timeStamps: String
    let message: String
    let data: [OrderData]
}

struct OrderData: Codable {
    let headerDetails: HeaderDetails
    let ItemDetails: [ItemDetails]
    let _id: String
    let createdAt: String
    let updatedAt: String
}

struct HeaderDetails: Codable {
    let customerName: String
    let address: String
    let mobile: Int
    let Email: String
}

struct ItemDetails: Codable {
    let itemName: String
    let itemQuantity: Int
    let itemPrice: Int
}


//struct OrderModel: Codable {
//    let error: Bool?
//    let message: String?
//    let data: [OrderData]
//}
//
//struct OrderData: Codable {
//    let _id: String
//    let headerDetails: HeaderDetails
//    let itemDetails: [ItemDetails]
//}
//
//struct HeaderDetails: Codable {
//    let customerName: String
//    let address: String
//    let mobile: Int
//    let Email: String
//}
//
//struct ItemDetails: Codable {
//    let itemName: String
//    let itemQuantity: Int
//    let itemPrice: Int
//}

