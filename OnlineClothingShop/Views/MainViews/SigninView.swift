//
//  SigninView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import SwiftUI

struct SigninView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    //    @State var firstname = ""
    //    @State var lastname = ""
    //    @State var email = ""
    //    @State var password = ""
    @State var isAleart = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State var username = ""
    @State var psw = ""
    //    @Binding var isPresented: Bool
    @Binding var firstname: String
    @Binding var lastname: String
    @Binding var email: String
    @Binding var picture: String
    @Binding var password: String
    //    @Binding var role: String
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
                    .alert(isPresented: $isAleart, content: {
                        let firstname = Text("No data")
                        let message = Text("Please fill all fields!")
                        return Alert(title: firstname, message: message)
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("User Creation"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                
                Button(action: {
                    if firstname != "" && lastname != "" && email != "" && password != "" {
                        ///                   var password = "password"
                        userViewModel.createUser(firstname: firstname, lastname: lastname, email: email, picture: "", password: password, role: "user") { result in
                            switch result {
                            case .success(let user):
                                
                                self.firstname = ""
                                self.lastname = ""
                                self.email = ""
                                self.password = ""
                                
                                self.alertMessage = "User created successfully"
                                self.showAlert = true
                                print("User created successfully: \(user)")
                                
                            case .failure(let error):
                        
                                self.alertMessage = "Something went wrong! Please try again!"
                                self.showAlert = true
                                print("Error creating user: \(error)")
                            }
                        }
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
                    NavigationLink(destination: LoginView(username: $username, psw: $psw)) {
                        Text("LogIn")
                            .foregroundColor(Color.Dark)
                            .bold()
                    }
                }
            }
            
        }
    }
}



//struct SigninView_Preview: PreviewProvider {
//    static var previews: some View {
//        SigninView()
//    }
//}
