//
//  LandingView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import SwiftUI

struct LandingView: View {
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var picture = ""
    @State var mobile = ""
    @State var address = ""
    @State var password = ""
    @State var usernames = ""
    @State var psws = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color.OffWhite).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding(.all, 40)
                    Text("Welcome !")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    //                Spacer()
                    Image("Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
    //                    .padding(.all , 10)
    //                Spacer()
                    Image("Divider")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .padding(.top, 20)
//                    PrimaryButton(title: "Get Started")
                    
                    NavigationLink(destination: LoginView(username: $usernames, psw: $psws)) {
                        Text("Get Started")
                            .font(tenorSans(22))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
        //                    .border(Color.purple)
                            .background(Color.Dark)
                            .cornerRadius(10)
                            .shadow(color: Color.Line.opacity(0.7), radius: 60, x: 10, y: 16)
                            .padding(.vertical)
                    }
                    
                    HStack {
                        Text("New around here? ")
                        NavigationLink(destination: SigninView(firstname: $firstname, lastname: $lastname, email: $email, picture: $picture, password: $password, mobile: $mobile, address: $address)) {
                            Text("Sign In")
                                .foregroundColor(.Dark)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .padding()
                .navigationBarHidden(true)
            }
        }
        
    }
}

struct LandingView_Preview: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(tenorSans(22))
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.Dark.opacity(1))
            .cornerRadius(10)
    }
}
