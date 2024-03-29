//
//  OnlineClothingShopApp.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

@main
struct OnlineClothingShopApp: App {
//    let userViewModel = UserViewModel()
        
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(UserViewModel())
                .environmentObject(LoginViewModel())
//                .environmentObject(ProductViewModel())
                
        }
    }
}
