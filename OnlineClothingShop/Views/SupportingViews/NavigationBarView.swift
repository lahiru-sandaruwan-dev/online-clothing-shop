//
//  NavigationBarView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-29.
//

import SwiftUI

struct NavigationBarView: View {
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var picture = ""
    @State var password = ""
    @State var mobile = ""
    @State var address = ""
    
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
        
                    CartView(userId: userId)
                    
                } else {
                    
                }
                
            } label: {
                Image("shopping bag")
                    .resizable()
                    .padding(.all, 10)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .background(Color.Line)
                    .padding()
            }
            
            let userId = UserSession.shared.userId ?? ""
            
            NavigationLink(destination: UserView(firstname: $firstname, lastname: $lastname, email: $email, picture: $picture, password: $password, mobile: $mobile, address: $address, userId: userId)) {
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
}

#Preview {
    NavigationBarView()
}
