//
//  ProductModelNew.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-29.
//

import Foundation
import SwiftUI

struct ProductDataModel: Codable  {
    let error: Bool?
    let message: String?
    let data: [PDataModel]
}

struct PDataModel: Hashable, Codable{
    let _id: String
    let productName: String
    let description: String
    let ProductCategory: String
    let productType: String
    let productImage: String
    let size: String
    let productPrice: Int
    let availableQuantity: Int
    let productColor: String
    let productStatus: Int
}
