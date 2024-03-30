//
//  CartView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-30.
//

import SwiftUI

struct CartView: View {
    @StateObject var cartVM = CartViewModel()
    @State var presentSideMenu = false
    @State var presentSideCart = false
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
                            Text("CART")
                                .font(tenorSans(24))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .onAppear {
                            cartVM.getCartByUserId(userId: "660675dd4c9b3ef89092f27e")
                        }
                        
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVStack(spacing: 20){
                                
                                ForEach(cartVM.productCartResult, id: \._id){ product in
                                    
                                    HStack(spacing: 15) {
                                        Image(product.productImage)
                                            .resizable()
                                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                            .frame(width: 130, height: 130)
                                            .cornerRadius(15)
                    
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(product.productName)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            
                                            HStack(spacing: 15) {
                                                Text(getPrice(value: Float(product.productPrice)))
                                                    .font(.title2)
                                                    .fontWeight(.heavy)
                                                .foregroundColor(.black)
                                                
                                                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                                
                                            }
                                            
                                            HStack{
                                                Button(action : {
                                                    cartVM.productCartResult[getIndex(product: product)].requestedQuantity -= 1
                                                }) {
                                                    Image(systemName: "minus")
                                                        .font(.system(size: 16, weight: .heavy))
                                                        .foregroundColor(.black)
                                                }

                                                Text("\(cartVM.productCartResult[getIndex(product: product)].requestedQuantity)")
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(.black)
                                                    .padding(.vertical, 5)
                                                    .padding(.horizontal, 10)
                                                    .background(Color.black.opacity(0.06))

                                                Button(action : {
                                                    cartVM.productCartResult[getIndex(product: product)].requestedQuantity += 1
                                                }) {
                                                    Image(systemName: "plus")
                                                        .font(.system(size: 16, weight: .heavy))
                                                        .foregroundColor(.black)
                                                }
                                                Spacer()
                                                Button(action : {
                                                    
                                                }, label : {
                                                    Image(systemName: "trash")
                                                        .font(.title3)
                                                        .foregroundColor(Color.red)
                                                })
                                            }
                                            .padding(.top , 10)
                                        }
                                        .padding()
                                    }
                                    .padding()
                                    
                                }
                            }
                            .background(Color.gray.opacity(0.1))
                            
                          
                            .padding(.top, 20)
                        }
                        VStack {
                            HStack {
                                Text("Total")
                                    .fontWeight(.heavy)
                                Spacer()
                                
                                Text(calculateTotalPrice())
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                            }
                            .padding([.top, .horizontal])
                            
                            Button(action : {
                                
                            }, label: {
                                Text("Check Out")
                                    .font(tenorSans(20))
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(Color.Dark.opacity(0.7))
                                    .cornerRadius(10)
                            })
                           
                                
                        }
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
    func getIndex(product: PCartModel)->Int{
        return cartVM.productCartResult.firstIndex {
            (product1)-> Bool in
            return product._id == product1._id
        } ?? 0
    }
    
    func getPrice(value : Float)-> String {
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func calculateTotalPrice()->String {
        var price: Float = 0
        
        cartVM.productCartResult.forEach{ (item) in
            price += Float(item.requestedQuantity) * Float(item.productPrice)
        }
        
        return getPrice(value: price)
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(userId: "660675dd4c9b3ef89092f27e")
    }
}
