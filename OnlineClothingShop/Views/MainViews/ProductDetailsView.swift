//
//  ProductDetailsView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

struct ProductDetailsView: View {
    @StateObject var productVM = ProductViewModel()
    @StateObject var cartViewModel = CartViewModel()
    @State var presentSideMenu = false
    @State var presentSideCart = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var productId: String
    
    //    var product: ProductModel
    var colorValue: String = ""
    @State var sizeValue = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ZStack {
                    VStack(spacing: 0) {
                        
                        ScrollView {
                            ForEach(productVM.productResult, id: \._id) { product in
                                Image(product.productImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 300)
                                    .clipped()
                                    .padding(20)
                                
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top) {
                                        Text(product.productName)
                                            .font(tenorSans(16))
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text("Rs.\(product.productPrice)")
                                            .font(tenorSans(28))
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.Default)
                                    }
                                    
                                    HStack {
                                        Text("Colors")
                                        HStack {
                                            Rectangle()
                                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                                .frame(width: 20, height: 20)
                                                .cornerRadius(10)
                                            Rectangle()
                                                .foregroundColor(.red)
                                                .frame(width: 20, height: 20)
                                                .cornerRadius(10)
                                            Rectangle()
                                                .foregroundColor(.green)
                                                .frame(width: 20, height: 20)
                                                .cornerRadius(10)
                                        }
                                        Spacer()
                                        Text("Size")
                                            .padding()
                                        Button(action : {
                                            self.sizeValue = "M"
                                        }, label: {
                                            Text("M")
                                                .foregroundColor(.black)
                                                .frame(width: 20)
                                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                            //                                        .padding(5)
                                            //                                        .background(Color.black)
                                        })
                                        Button(action : {
                                            self.sizeValue = "L"
                                        }, label: {
                                            Text("L")
                                                .foregroundColor(.black)
                                                .frame(width: 20)
                                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                            //                                        .padding(5)
                                            //                                        .background(Color.black)
                                        })
                                        Button(action : {
                                            self.sizeValue = "XL"
                                        }, label: {
                                            Text("XL")
                                                .foregroundColor(.black)
                                                .frame(width: 25)
                                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                            //                                        .padding(5)
                                            //                                        .background(Color.black)
                                        })
                                        
                                        
                                    }
                                    HStack {
                                        Text("Available Qty")
                                        Spacer()
                                        Text("\(product.availableQuantity)")
                                            .foregroundColor(.white)
                                            .padding(4)
                                            .frame(width: .infinity)
                                            .background(Color.green)
                                    }
                                    .alert(isPresented: $showAlert) {
                                        Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                    }
                                    
                                    
                                    HStack {
                                        
                                        Button(action : {
                                            if let userId = UserSession.shared.userId {
                                                
                                                cartViewModel.addProductToCart(productName: product.productName, size: "M", color: "red", requestedQuantity: "1", userId: userId){ result in
                                                    switch result {
                                                    case .success(let user):
                                                        
                                                        self.alertMessage = "Added to the Cart successfully"
                                                        self.showAlert = true
                                                        print("User created successfully: \(user)")
                                                        NavigationLink(destination: CheckoutViewNew(userId: userId)) {
                                                            EmptyView()
                                                        }
                                                    case .failure(let error):
                                                        let message = UserSession.shared.message
                                                        self.alertMessage = "Item Already Added to Cart!"
                                                        self.showAlert = true
                                                        print("Error creating user: \(error)")
                                                    }
                                                }
                                                
                                            } else {
                                                
                                            }
                                        }, label: {
                                            Text("Buy Now")
                                                .foregroundColor(Color.Dark)
                                                .frame(width: 160, height: 45)
                                                .border(Color.Dark)
                                                .cornerRadius(3)
                                        })
                                        Spacer()
                                        Button(action : {
                                            if let userId = UserSession.shared.userId {
                                                
                                                cartViewModel.addProductToCart(productName: product.productName, size: "M", color: "red", requestedQuantity: "1", userId: userId){ result in
                                                    switch result {
                                                    case .success(let user):
                                                        
                                                        self.alertMessage = "Added to the Cart successfully"
                                                        self.showAlert = true
                                                        print("User created successfully: \(user)")
                                                        
                                                    case .failure(let error):
                                                        let message = UserSession.shared.message
                                                        self.alertMessage = "Item Already Added to Cart!"
                                                        self.showAlert = true
                                                        print("Error creating user: \(error)")
                                                    }
                                                }
                                                
                                            } else {
                                                
                                            }
                                        }, label: {
                                            Text("Add To Cart")
                                                .foregroundColor(.white)
                                                .frame(width: 160, height: 45)
                                                .background(Color.Dark.opacity(0.8))
                                                .cornerRadius(5)
                                        })
                                    }
                                    .padding(.top, 10)
                                    
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding([.leading, .trailing], 20)
                                
                                Image("Divider")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .padding(.top, 10)
                                
                                Text("DESCRPTION")
                                    .font(tenorSans(18))
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                                
                                Text("\(product.description)")
                                    .font(tenorSans(18))
                                    .foregroundColor(.black)
                                    .padding(.top, 3)
                                    .padding([.leading, .trailing], 20)
                                
                                
                            }
                        }
                        
                        NavigationBarView()
                        
                    }
                    
                    .onAppear {
                        productVM.getById(productId: productId)
                        //                    productVM.fetch()
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
                
//                SideMenu()
//                SideCart()
            }
            .navigationBarHidden(true)
        }
    }
    
    
}


struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(productId: "6606ea244c9b3ef89092f3f8")
    }
}


