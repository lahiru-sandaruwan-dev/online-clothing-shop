//
//  SigninView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import SwiftUI

struct SigninView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var isAleart = false
    
//    @Binding var isPresented: Bool
//    @Binding var firstname: String
//    @Binding var lastname: String
//    @Binding var email: String
//    @Binding var password: String
//    @State private var wrongPassword = 0
//    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 84, height: 84)
                    .padding(.all, 40)
                Text("Sign In")
                    .font(.title)
                    .bold()
                    .padding()
                TextField("First Name", text: $firstname)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.Dark.opacity(0.8), width: 300)
                
                TextField("Last Name", text: $lastname)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.Dark.opacity(0.8), width: 300)
                
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.Dark.opacity(0.8), width: 300)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
//                    .border(Color.Dark.opacity(0.8), width: CGFloat(wrongPassword))
                
//                    NavigationLink(destination: LoginView()) {
//                        Text("Confirm")
//                            .font(tenorSans(20))
//                            .bold()
//                            .foregroundColor(.white)
//                            .frame(width: 300, height: 50)
//                            .background(Color.Dark.opacity(0.7))
//                            .cornerRadius(10)
//                        }
                    .alert(isPresented: $isAleart, content: {
                        let firstname = Text("No data")
                        let message = Text("Please fill all fields!")
                        return Alert(title: firstname, message: message)
                    })
                Button(action: {
                    if firstname != "" && lastname != "" {
                        let parameters: [String: Any] = ["firstName": firstname, "lastName": lastname]
                        userViewModel.createUser(parameters: parameters)
                    } else {
                        isAleart.toggle()
                    }
                }, label: {
                    Text("Confirm")
                        .font(tenorSans(20))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.Dark.opacity(0.7))
                        .cornerRadius(10)
                })
                    Image("Divider")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .padding(.top, 20)
                    
                    Spacer()
                
                HStack {
                    Text("Have an account? ")
                    NavigationLink(destination: LoginView()) {
                        Text("LogIn")
                            .foregroundColor(Color.Dark)
                            .bold()
                    }
                }
            }
        }
        
    }
}

struct SigninView_Preview: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
