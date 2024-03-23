//
//  CartItemModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import Foundation

class CartItem {
    var product: ProductModel
    var count: Int = 0
    
    init(product: ProductModel, count: Int) {
        self.product = product
        self.count = count
    }
    
}

