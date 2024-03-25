//
//  LoginView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var psw = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 84, height: 84)
                    .padding(.all, 40)
//                Spacer()
                Text("Login")
                    .font(.title)
                    .bold()
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.Dark.opacity(0.8), width: CGFloat(wrongUsername))
                
                SecureField("Password", text: $psw)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.Dark.opacity(0.8), width: CGFloat(wrongPassword))
                
//                Button("Login") {
//                    authenticateUser(username: username, password: password)
//                }
//                .font(tenorSans(20))
//                .bold()
//                .foregroundColor(.white)
//                .frame(width: 300, height: 50)
//                .background(Color.Dark.opacity(0.7))
//                .cornerRadius(10)
                
                NavigationLink(destination: HomeView()) {
                    Text("LogIn")
                        .font(tenorSans(20))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.Dark.opacity(0.7))
                        .cornerRadius(10)
            }
//                .padding(.bottom, 40)
                
                Image("Divider")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding(.top, 20)
                
                VStack {
                    SocialLoginButton(image: Image("apple"), text: Text("Sign In with Apple"))
                    SocialLoginButton(image: Image("google"), text: Text("Sign In with Google"))
                }
                .padding()
                
                Spacer()
                HStack {
                    Text("New around here? ")
                    NavigationLink(destination: SigninView(firstname: $firstname, lastname: $lastname, email: $email, password: $password)) {
                        Text("Sign In")
                            .foregroundColor(Color.Dark)
                            .bold()
                    }
                }
                
//                NavigationLink(destination: Text("You are logged in @\(username)"), isActive: $showingLoginScreen) {
//                    EmptyView()
//                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "lahiru" {
            wrongPassword = 0
            if password.lowercased() == "123" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

//struct LoginView_Preview: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

struct SocialLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(tenorSans(18))
            Spacer()
        }
        .padding()
        .frame(width: 300, height: 50)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.Dark.opacity(0.3), radius: 50, x: 1, y: 1)
    }
}
