//
//  NavigationBarView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-29.
//

import SwiftUI

struct NavigationBarView: View {
    
    var body: some View {
        HStack {
            NavigationLink{
                HomeView()
            } label: {
                Image("Home")
                    .resizable()
                    .padding(.all, 10)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .background(Color.Line)
                    .padding()
            }
                
//                                Spacer()
            NavigationLink{
                ProductsList()
            } label: {
                Image("grid view")
                    .resizable()
                    .padding(.all, 10)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .background(Color.Line)
                    .padding()
            }
            
            NavigationLink{
                
                if let userId = UserSession.shared.userId {
                    // Do something with userId
                    CartView(userId: userId)
                    
                } else {
                    
                }
                
//                SideCartViewTemp()
            } label: {
                Image("shopping bag")
                    .resizable()
                    .padding(.all, 10)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .background(Color.Line)
                    .padding()
            }
            
            
//                                Spacer()
            Image("User")
                .resizable()
                .padding(.all, 10)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .background(Color.Line)
                .padding()
                
        }
    }
}

#Preview {
    NavigationBarView()
}
