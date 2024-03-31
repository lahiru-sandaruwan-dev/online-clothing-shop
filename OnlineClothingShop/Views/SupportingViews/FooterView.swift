//
//  FooterView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("About Us")
                .bold()
                .foregroundColor(.white)
                .font(.title2)
            Image("Divider")
            Spacer()
            Text("Dream Land Fashion Mart")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .foregroundColor(.white)
                .padding()
            Text("support'@'dreamland.fashion")
                .font(tenorSans(20))
                .bold()
                .foregroundColor(.white)
            Text("No. 70, Colombo Road. Colombo 07")
                .foregroundColor(.white)
            Text("Sri Lanka")
                .foregroundColor(.white)
            Text("+94 112861064 / +94 112861065")
                .foregroundColor(.white)
            
            HStack {
                Image("Instagram")
                    .resizable()
                    .frame(width: 35, height: 35)
                Image("Twitter")
                    .resizable()
                    .frame(width: 35, height: 35)
//                Image("YouTube")
//                    .resizable()
//                    .frame(width: 35, height: 35)
            }
            
                Spacer()
            
            
        }
        .padding()
        .frame(width: 500, height: 360)
        .background(Color.Dark.opacity(0.6))
        .cornerRadius(10)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
