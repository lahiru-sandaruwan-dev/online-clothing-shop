//
//  CartModel.swift
//  OnlineClothingShop
//
//  Created by Akindu Bogahawatta on 2024-03-30.
//

import Foundation
import SwiftUI

struct ProductCartModel: Codable  {
    let error: Bool?
    let message: String?
    let data: [PCartModel]
}

struct PCartModel: Hashable, Codable{
    let _id: String
    let productName: String
    let size: String
    let productPrice: Int
    let availableQuantity: Int
    var requestedQuantity: Int
    let totalPrice: Int
    let color: String
    let productImage: String
    let userId: String
}
