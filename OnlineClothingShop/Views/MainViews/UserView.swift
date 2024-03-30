//
//  UseView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-30.
//

import SwiftUI

struct UserView: View {
    @StateObject var userVM = UserViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @State var presentSideMenu = false
    @State var presentSideCart = false
    @State private var isSheetPresented = false
    
//    @State var firstname = ""
//    @State var lastname = ""
//    @State var email = ""
//    @State var picture = ""
//    @State var password = ""
//    @State var mobile = ""
//    @State var address = ""
    
    @State var isAleart = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @Binding var firstname: String
    @Binding var lastname: String
    @Binding var email: String
    @Binding var picture: String
    @Binding var password: String
    @Binding var mobile: String
    @Binding var address: String
    var userId: String
    
    //    private let adaptiveColumns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        HStack {
                            Text("User Profile")
                                .font(tenorSans(24))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                            Button(action : {
                                self.isSheetPresented = true
                            }, label: {
                                Text("Edit")
                                    .foregroundColor(Color.white)
                                    .bold()
                                    .frame(width:60 , height: 45)
                                    .background(Color.Dark)
                                    .cornerRadius(8)
                            })
                            .padding(10)
                        }
                        .sheet(isPresented: $isSheetPresented) {
                            // Content of the sheet goes here
                            // For example:
                            HStack {
                                Text("Edit User Profile")
                                    .font(tenorSans(24))
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                                Spacer()
                                Button(action : {
                                    self.isSheetPresented = false
                                }, label: {
                                    Text("Close")
                                        .foregroundColor(Color.white)
                                        .bold()
                                        .frame(width:60 , height: 45)
                                        .background(Color.red)
                                        .cornerRadius(8)
                                })
                            }
                            .padding()
                            Spacer()
                            VStack {
                                Text("User Details")
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
                                
                                TextField("Mobile", text: $mobile)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                                    .border(Color.Dark.opacity(0.8), width: 300)
                                
                                TextField("Address", text: $address)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                                    .border(Color.Dark.opacity(0.8), width: 300)
                                
                                    .alert(isPresented: $isAleart, content: {
                                        let firstname = Text("No data")
                                        let message = Text("Please fill all fields!")
                                        return Alert(title: firstname, message: message)
                                    })
                                    .alert(isPresented: $showAlert) {
                                        Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                    }
                                
                                Button(action : {
                                    if firstname != "" && lastname != "" && mobile != "" && address != "" {
                    
                                        let user = UserSession.shared.userId ?? ""
                                        userViewModel.udateUser(userId: userId, firstname: firstname, lastname: lastname, mobile: mobile, address: address) { result in
                                            switch result {
                                            case .success(let user):
                                                
                                                self.firstname = ""
                                                self.lastname = ""
                                                self.mobile = ""
                                                self.address = ""
                                                
                                                self.alertMessage = "User Update successfully"
                                                self.showAlert = true
                                                userViewModel.getUserById(userId: userId)
                                                self.isSheetPresented = false
                                                if isSheetPresented == false {
                                                    updateDetails()
                                                }
                                                
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
                                }, label : {
                                    Text("Edit User")
                                        .font(tenorSans(20))
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: 300, height: 50)
                                        .background(Color.Dark.opacity(0.7))
                                        .cornerRadius(10)
                                })
                                
                            }
                            Spacer()
                        }
                        .onAppear {
                            //                            cartVM.getCartByUserId(userId: userId)
                            //                            let user = UserSession.shared.userId
                            userVM.getUserById(userId: userId)
                            if isSheetPresented == false {
                                updateDetails()
                            }
                           
                        }
                        
                        
                        //                        ScrollView(.vertical, showsIndicators: false){
                        ForEach(userVM.userResult , id: \._id){ user in
                            VStack {
                                Image("user 1")
                                    .resizable()
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .frame(width: 150, height: 150)
                                    .clipped()
                                    .shadow(radius: 3)
                                
                                Text(user.firstName)
                                    .font(.title)
                                    .fontWeight(.medium)
                                
                                Form {
                                    Section {
                                        HStack {
                                            Text("First name")
                                            Spacer()
                                            Text(user.firstName)
                                                .foregroundColor(.gray)
                                                .font(.callout)
                                                .frame(alignment: .leading)
                                        }
                                        HStack {
                                            Text("Last Name")
                                            Spacer()
                                            Text(user.lastName)
                                                .foregroundColor(.gray)
                                                .font(.callout)
                                                .frame(alignment: .leading)
                                        }
                                        HStack {
                                            Text("Email")
                                            Spacer()
                                            Text(user.email)
                                                .foregroundColor(.gray)
                                                .font(.callout)
                                                .frame(alignment: .leading)
                                        }
                                        HStack {
                                            Text("Mobile")
                                            Spacer()
                                            Text(user.mobile)
                                                .foregroundColor(.gray)
                                                .font(.callout)
                                                .frame(alignment: .leading)
                                        }
                                        HStack {
                                            Text("Address")
                                            Spacer()
                                            Text(user.address)
                                                .foregroundColor(.gray)
                                                .font(.callout)
                                                .frame(alignment: .leading)
                                        }
                                    }
                                }
                            }
                            .environment(\.colorScheme, .light)
                        }
                        //                        }
                        
                        
                        
                        .padding(10)
                        
                        NavigationBarView()
                            .edgesIgnoringSafeArea(.all)
                    }
                    .padding(.top, 56)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    HeaderView {
                        presentSideMenu.toggle()
                    } cartAction: {
                        presentSideCart.toggle()
                    }
                }
                
                SideMenu()
                SideCart()
            }
            .navigationBarHidden(true)
        }
    }
    
    
    
    func updateDetails(){
        userVM.getUserById(userId: userId)
    }
    
    
    @ViewBuilder
    private func SideMenu() -> some View {
        SideView(isShowing: $presentSideMenu, content: AnyView(SideMenuViewContents(presentSideMenu: $presentSideMenu)), direction: .leading)
    }
    
    @ViewBuilder
    private func SideCart() -> some View {
        SideView(isShowing: $presentSideCart, content: AnyView(SideCartViewContents(presentSideMenu: $presentSideCart)), direction: .trailing)
    }
    
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView(userId: "660675dd4c9b3ef89092f27e")
//    }
//}

//#Preview {
//    UserView(userId: "660675dd4c9b3ef89092f27e")
//}
