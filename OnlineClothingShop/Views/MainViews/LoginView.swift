//
//  LoginView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Binding var username: String
    @Binding var psw: String
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var isAleart = false
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State var isLoggedIn = false
    
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var picture = ""
    @State var password = ""
   
    @State private var isHomeViewPresented = false
    
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
                TextField("Email", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.Dark.opacity(0.8), width: 300)
                
                SecureField("Password", text: $psw)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.Dark.opacity(0.8), width: 300)
                
//                Button("Login") {
//                    authenticateUser(username: username, password: password)
//                }
//                .font(tenorSans(20))
//                .bold()
//                .foregroundColor(.white)
//                .frame(width: 300, height: 50)
//                .background(Color.Dark.opacity(0.7))
//                .cornerRadius(10)
                    .alert(isPresented: $isAleart, content: {
                        let firstname = Text("No data")
                        let message = Text("Please fill all fields!")
                        return Alert(title: firstname, message: message)
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("User Creation"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
//                    .sheet(isPresented: $isHomeViewPresented) {
//                        HomeView()
//                    }
//                
                Button(action: {
                    if username != "" && psw != "" {
                        loginViewModel.login(email: username, password: psw) { result in
                            switch result {
                            case .success(let user):
                                
                                self.username = ""
                                self.psw = ""
                                
//                                HomeView()
//                                self.navigateToHomeView()
                                self.isLoggedIn = true
                                
                                print("User Logged successfully: \(user)")
                                
                            case .failure(let error):
                        
                                self.alertMessage = "Something went wrong! Please check email or password!"
                                self.showAlert = true
                                print("Error Logging user: \(error)")
                            }
                        }
                    } else {
                        isAleart.toggle()
                    }

                }, label : {
                    Text("LogIn")
                        .font(tenorSans(20))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.Dark.opacity(0.7))
                        .cornerRadius(10)
                })
                
//                NavigationLink(destination: HomeView()) {
//                    
//            }
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
                    NavigationLink(destination: SigninView(firstname: $firstname, lastname: $lastname, email: $email, picture: $picture, password: $password)) {
                        Text("Sign In")
                            .foregroundColor(Color.Dark)
                            .bold()
                    }
                }
                
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                               EmptyView()
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
    
    func navigateToHomeView() {
        // Push HomeView onto the navigation stack
        // Example assuming you're using NavigationView
//        self.presentationMode.wrappedValue.dismiss()
        self.isHomeViewPresented = true
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
