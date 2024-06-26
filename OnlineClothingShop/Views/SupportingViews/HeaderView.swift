//
//  HeaderView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

struct HeaderView: View {
    var menuAction: ButtonAction
    var cartAction: ButtonAction
    
    var body: some View {
        ZStack{
            HStack{
                Spacer()
                NavigationLink(destination: HomeView()) {
                                   Image("logo")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 84, height: 80)
                               }
                
                Spacer()
                
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .frame(height: 56)
        .background(.white)
        .zIndex(1)
        .shadow(radius: 0.3)
    }
}


