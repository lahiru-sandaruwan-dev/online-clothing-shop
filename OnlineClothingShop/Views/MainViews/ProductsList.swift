//
//  ProductsList.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

struct ProductsList: View {
    @StateObject var productVM = ProductViewModel()
    @EnvironmentObject var cartViewModel : CartViewModel
    @State var presentSideMenu = false
    @State var presentSideCart = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    //    private let adaptiveColumns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        HStack {
                            Text("PRODUCTS")
                                .font(tenorSans(24))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .onAppear {
                            productVM.fetch()
                        }
                        
                        ScrollView(.vertical) {
                            VStack {
                                ScrollView{
                                    
                                    ForEach(productVM.productResult,id: \._id){ product in
                                        ZStack {
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(height: 160)
                                                .foregroundStyle(.white)
                                                .shadow(radius: 5)
                                            
                                            HStack{
                                                HStack {
                                                    Image(product.productImage)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150, height: 120)
                                                    
                                                    Spacer()
                                                    VStack{
                                                        Text(product.productName)
                                                            .multilineTextAlignment(.leading)
                                                        
                                                        VStack {
                                                            NavigationLink(destination: ProductDetailsView(productId: product._id)) {
                                                                Text("Details")
                                                                    .foregroundColor(Color.Dark)
                                                                    .frame(width: 120, height: 30)
                                                                    .border(Color.Dark)
                                                                    .cornerRadius(3)
                                                            }
                                                            .alert(isPresented: $showAlert) {
                                                                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                                            }
                                                            //
                                                            
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
                                                                    .frame(width: 120, height: 30)
                                                                    .background(Color.Dark.opacity(0.8))
                                                                    .cornerRadius(5)
                                                            })
                                                            
                                                        }
                                                        
                                                    }
                                                    Spacer()
                                                }
                                                
                                            }
                                        }.padding(.horizontal)
                                            .padding(.top)
                                        
                                        Spacer()
                                    }
                                }
                                .scrollIndicators(.hidden)
                            }.padding([.leading, .trailing], 20)
                            //                        FooterView()
                        }
                        
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

            }
            .navigationBarHidden(true)
        }
    }
    
    
}

struct ProductsList_Previews: PreviewProvider {
    static var previews: some View {
        ProductsList()
    }
}
